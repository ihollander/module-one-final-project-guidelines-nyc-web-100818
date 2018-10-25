# main game class
class Game
  include DisplayMethods

  attr_accessor :lboard, :player, :classmates, :already_played, :player_quit, :easter_egg

  def initialize(player)
    @player = player
    # create classmates array
    @classmates = []
    @player_quit = false
    @easter_egg = false
    init_random_classmates
    @lboard = Leaderboard.new(self.player, self.classmates)
  end

  def init_random_classmates
    characters = Classmate.all.select {|character| character.occupation == "student" || character.occupation == "staff" }.sample(9)
    characters.each do |character|
      classmate_hash = {
        name: character.name,
        gender: character.gender,
        house_id: character.house_id,
        wand: character.wand,
        patronus: character.patronus,
        pet: character.pet,
        birth_year: character.birth_year,
        charm_points: character.charm_points,
        hit_points: character.hit_points,
        occupation: character.occupation
      }
      classmate = Classmate.new(classmate_hash)
      classmate.spells = character.spells
      classmate.charms = Charm.all
      @classmates << classmate
    end
  end # get_random_classmates

  def play
    until self.over?
      self.turn # take a turn
    end
  end

  def lost?
    self.classmates.any?{|classmate| classmate.victories == 3 || classmate.friends == 3}
  end

  def won?
    self.player.victories == 3 || self.player.friends == 3
  end

  def over?
     self.won? || self.lost? || self.player_quit || self.easter_egg
  end

  def turn
    disolve_screen(30,0.02) # clear the screen at the beginning of each turn (from display_methods)
    display_delimiter_magenta("^") # show delimiter

    input = self.prompt_turn_input # get player's choice
    case input.upcase
      when "Q"
        self.player_quit = true
      when "L"
        disolve_screen(15,0.02)
        self.lboard.display_all
        display_delimiter_magenta("^","Press [ENTER] to continue")
        gets
      when "W"
        disolve_screen(15,0.02)
        classmate = self.get_classmate_encounter # get classmate for this round
        classmate.display_intro # show the classmate info
        encounter_character(classmate) # enter combat mode (taunt/compliment)
        simulate_ai_combat # after player combat, simulate AI combat
        display_delimiter_magenta("^","Press [ENTER] to continue")
        gets
    end
  end

  def prompt_turn_input
    prompt = "Options\n"
    prompt += "Check [L]eaderboard | [W]ander the hallways | [Q]uit\n"
    prompt += "\n"
    prompt += "What will you do?"
    ask(prompt, ["L","W","Q"])
  end

  def encounter_character(classmate)
    input = ask("[T]aunt or [C]ompliment?", ["T","C"])
    case input.upcase
      when "T"
        combat_round = SpellCombat.new(self.player, classmate)
        combat_round.start
        if combat_round.easter_egg
          self.easter_egg = true
        end
      when "C"
        combat_round = CharmCombat.new(self.player, classmate)
        combat_round.start
    end
  end

  def get_classmate_encounter
    classmate = self.get_random_classmate # get a random classmate
    self.player.classmates_faced << classmate # keep track of who the student has met
    self.already_played = [player, classmate] # prompts user to see what they want every turn
    classmate
  end

  def simulate_ai_combat
    4.times do
      classmate_1 = get_ai_classmate
      self.already_played += [classmate_1]
      classmate_2 = get_ai_classmate
      self.already_played += [classmate_2]
      round = ["T","C"].sample
      if round == "T"
        combat_round = SpellCombat.new(classmate_1, classmate_2)
        combat_round.start_ai_round
      else
        combat_round = CharmCombat.new(classmate_1, classmate_2)
        combat_round.start_ai_round
      end
    end
  end

  def get_ai_classmate
    self.classmates.select{|classmate| !self.already_played.include?(classmate) }.sample
  end

  def get_random_classmate
    self.classmates.select{|classmate| !self.player.classmates_faced.include?(classmate) }.sample
  end

end
