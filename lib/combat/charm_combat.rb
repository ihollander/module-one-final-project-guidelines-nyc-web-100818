class CharmCombat
  attr_accessor :player, :classmate, :player_cp, :classmate_cp

  def initialize(player, classmate)
    @player = player
    @classmate = classmate
    @player_cp = 0
    @classmate_cp = 0
  end

  def display_stats
    puts "Your charm points: #{self.player_cp}. Charm points needed to make you friendly: #{self.player.charm_points}."
    puts "#{self.classmate.name}'s charm points: #{self.classmate_cp}. Charm points needed to make #{self.classmate.name} friendly: #{self.classmate.charm_points}."
  end

  def display_results
    result = @player_cp >= self.player.charm_points ? "#{self.classmate.name} smittened you!" : "You smittened #{self.classmate.name}!"
    puts result
  end

  def calculate_results
    @player_cp >= self.player.charm_points ? self.classmate.friends += 1 : self.player.friends += 1
  end

  def start
    whose_turn = ["player","classmate"].sample # random player starts

    until over?
      display_stats # show stats each turn
      if whose_turn == "player"
        player_charm = prompt_player_for_charm
        self.classmate_cp += player_charm.points
        puts "#{self.classmate.name} blushes. #{player_charm.points} charm points added!"
        whose_turn = "classmate"
      else
        puts "It's #{self.classmate.name}'s turn...'"
        sleep(1)
        classmate_charm = self.classmate.charms.sample
        @player_cp += classmate_charm.points
        puts "#{self.classmate.name} said: #{classmate_charm.dialog}"
        puts "#{classmate_charm.points} added!"
        whose_turn = "player"
      end
    end

    calculate_results
    display_results
  end

  def start_ai_round
    whose_turn = ["player","classmate"].sample # random player starts
    until over?
      if whose_turn == "player"
        player_charm = self.player.charms.sample
        self.classmate_cp += player_charm.points
        whose_turn = "classmate"
      else
        classmate_charm = self.classmate.charms.sample
        @player_cp += classmate_charm.points
        whose_turn = "player"
      end
    end
    calculate_results
  end

  def over?
    self.player_cp >= self.player.charm_points || self.classmate_cp >= self.classmate.charm_points
  end

  def prompt_player_for_charm
    charm = nil
    until charm
      puts self.player.display_charm_options
      charm_input = gets.chomp
      if valid_charm_input?(charm_input)
        charm = self.player.charms[charm_input.to_i - 1]
      else
        puts "Invalid input!"
      end
    end
    charm
  end

  def valid_charm_input?(input_string)
    charm_number = input_string.to_i
    charm_number.to_s == input_string && charm_number.between?(1, self.player.charms.length) # check valid number
  end

end
