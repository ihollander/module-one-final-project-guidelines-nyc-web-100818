class CharmCombat
  include DisplayMethods

  attr_accessor :player, :player_damage, :player_charm_options, :classmate, :classmate_damage, :classmate_charm_options, :whose_turn

  def initialize(player, classmate)
    @player = player
    @classmate = classmate
    @player_damage = 0
    @classmate_damage = 0
    @whose_turn = [@player.name, @classmate.name].sample
    @player_charm_options = @player.charms
    @classmate_charm_options = @classmate.charms
  end

  def display_combat_screen(last_action)
    clear_screen
    display_stats # stats
    puts ""
    puts last_action # Current action
    puts ""
    if over?
      display_results
    else
      puts "It's #{self.whose_turn}'s turn..."
    end
    puts ""
    # Prompt box for player actions (spells)
  end

  def display_stats
    player_damage = PASTEL.red("♥" * self.player_damage)
    classmate_damage = PASTEL.red("♥" * self.classmate_damage)
    puts "#{self.player.name} charmed: #{player_damage}".ljust(SCREEN_SIZE[0] / 2) + "#{self.classmate.name} charmed: #{classmate_damage}".ljust(SCREEN_SIZE[0] / 2)
  end

  def display_results
    result = self.player_damage >= self.player.charm_points ? "#{self.classmate.name} charmed you!" : "You charmed #{self.classmate.name}!"
    puts result
  end

  def display_charm_effect(charm, caster, target)
    reaction = ""
    case charm.points
      when 1, 2, 3
        reaction = "#{target.name} smiles."
      when 4, 5, 6
        reaction = "#{target.name} blushes!"
      when 7, 8, 9
        reaction = "#{target.name} gives #{caster.name} a big ol hug!"
      when 10
        reaction = "#{target.name} kisses #{caster.name}! Aww."
    end
    result = "#{caster.name} says: #{charm.dialog}\n"
    result += "#{reaction}\n"
    result += "#{charm.points} charm added!"
    result
  end

  def start
    last_action = "You're having a nice conversation with #{self.classmate.name}!"
    display_combat_screen(last_action)

    binding.pry
    until over?
      display_combat_screen(last_action)
      if self.whose_turn == self.player.name
        charm = prompt_player_for_charm
        self.player_charm_options.delete(charm)
        self.classmate_damage += charm.points
        last_action = display_charm_effect(charm, self.player, self.classmate)
        self.whose_turn = self.classmate.name
      else
        sleep(3)
        charm = self.classmate_charm_options.sample
        self.classmate_charm_options.delete(charm)
        self.player_damage += charm.points
        last_action = display_charm_effect(charm, self.classmate, self.player)
        self.whose_turn = self.player.name
      end
    end

    calculate_results
    display_combat_screen(last_action)
  end

  def start_ai_round
    until over?
      if self.whose_turn == self.player.name
        charm = self.player_charm_options.sample
        self.classmate_damage += charm.points
        self.whose_turn = self.classmate.name
      else
        charm = self.classmate_charm_options.sample
        self.player_damage += charm.points
        self.whose_turn = self.player.name
      end
    end
    calculate_results
  end

  def over?
    self.player_damage >= self.player.charm_points || self.classmate_damage >= self.classmate.charm_points
  end

  def calculate_results
    self.player_damage >= self.player.charm_points ? self.classmate.friends += 1 : self.player.friends += 1
  end

  def prompt_player_for_charm
    charm = nil
    available_charms = self.player_charm_options.sample(4)
    until charm
      puts self.display_charm_options(available_charms)
      charm_input = gets.chomp
      if valid_charm_input?(charm_input, available_charms)
        charm = available_charms[charm_input.to_i - 1]
      else
        puts "Invalid input!"
      end
    end
    charm
  end

  def display_charm_options(available_charms)
    charm_options = []
    available_charms.each_with_index{|charm, index|
      charm_options << "[#{index + 1}] #{charm.dialog}"
    }
    "Say something nice: \n#{charm_options.join("\n")}"
  end

  def valid_charm_input?(input_string, available_charms)
    charm_number = input_string.to_i
    charm_number.to_s == input_string && charm_number.between?(1, available_charms.length) # check valid number
  end

end
