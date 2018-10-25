# main game class
class Game
  include DisplayMethods

  attr_accessor :lboard, :player, :classmates, :already_played

  def initialize
    # create classmates array
    @classmates = []
    get_random_classmates
  end

  def get_random_classmates
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

  def initialize_leaderboard
    @lboard = Leaderboard.new(self.player, self.classmates)
  end

  def lost?
    self.classmates.any?{|classmate| classmate.victories == 3 || classmate.friends == 3}
  end

  def won?
    self.player.victories == 3 || self.player.friends == 3
  end

  def over?
     self.won? || self.lost?
  end

  def turn_prompt
    disolve_screen(SCREEN_SIZE[1],0.02) # from display_methods
    UI.delimiter_magenta("^")
    puts "Options"
    puts "Check leaderboard(l) | Wander the hallways (w) | Quit (q)"
    puts" "
    self.turn_prompt_input
  end

  def turn_prompt_input
    puts "What will you do?"
    print "⚡: "
    input = gets.chomp
    if input.downcase == "q"
      #TODO remove this and add exit game method
    elsif input.downcase == "l"
      disolve_screen(15,0.02)
      self.lboard.display_all
      UI.continue_prompt_magenta
      self.turn_prompt
    elsif input.downcase == "w"
      disolve_screen(15,0.02)
    else
      puts "Invalid input\n \n"
      self.turn_prompt_input
    end
  end

  def turn
    self.turn_prompt
    current_classmate = classmate = self.get_classmate_encounter
    classmate.display_intro # show the classmate info
    encounter_character(current_classmate)
    simulate_ai_combat
    UI.continue_prompt_magenta
  end

  def encounter_character(classmate)
    valid_input = false
    until valid_input
      puts "Taunt or compliment? [T]/[C]"
      input = gets.chomp
      if input.upcase == "T"
        valid_input = true
        combat_round = SpellCombat.new(self.player, classmate)
        combat_round.start
      elsif input.upcase == "C"
        valid_input = true
        combat_round = CharmCombat.new(self.player, classmate)
        combat_round.start
      else
        puts "Invalid input!"
      end
    end
  end

  def get_classmate_encounter
    classmate = self.get_random_classmate
    # get a random classmate
    self.player.classmates_faced << classmate
    # keep track of who the student has met
    @already_played = [player, classmate]
    # prompts user to see what they want every turn
    classmate
  end

  def simulate_ai_combat
    4.times do
      classmate_1 = get_available_classmate_for_round
      self.already_played += [classmate_1]
      classmate_2 = get_available_classmate_for_round
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

  def get_available_classmate_for_round
    self.classmates.select{|classmate| !self.already_played.include?(classmate) }.sample
  end

  def get_random_classmate
    available_classmates = self.classmates.select{|classmate|
      self.player.classmates_faced.include?(classmate) == false
    }
    available_classmates.sample
  end

end
