# UI - prompts, display messages, etc
class UI
  attr_accessor :game

  def display_welcome
    puts ColorizedString["This is blue"].colorize(:light_blue)
    # binding.pry
    puts "Welcome to Hogwarts!"
    puts "In here you can befriend or defeat your fellow Hogwarts classmates."
  end

  def prompt_for_player_name
    print "Enter your name: "
    gets.chomp
  end

  def display_player_info(player)
    puts "Congratulation!You have been sorted into #{player.house.name} House!"
    gets
    puts "#{player.house.founder} founded the House hoping to find young wizards that have #{player.house.values}."
    gets
    puts "Your Head of House is #{player.house.head_of_house}."
    puts "Your House ghost is #{player.house.house_ghost} "
    puts "Your House colors are #{player.house.color}"
    gets
    puts "Your wand: #{player.wand}! Your pet: #{player.pet}! Your patronus: #{player.patronus}!"
  end

  # a. if taunt is picked, go to combat screen (8)
  def charm_combat(classmate)
    player_charm_counter = 0
    opponent_charm_counter = 0
    until player_charm_counter == player.charm_points || opponent_charm_counter == opponent.charm_points
      # 8. Combat screen: show player's stats and opponent's stats and prompt user to pick a spell to cast
      puts "#{player.name} stats: #{player_start}"
      puts "#{opponent.name} stats: #{opponent_start}"
      # player.spells.map{||}
      puts "Pick a nice thing to say. 1) You smell lovely! 2) I like your shoes. 3) Your pet rat is SO fuzzy!"
      charm_input = gets.chomp

      # look up the charm
      charm = Charm.all.find_by(dialog: charm_input)

      if charm
        # a. Show effect of spell. If opponent's hit points reach 0, go to combat over screen (8c).
        opponent_charm_counter += charm.point
        puts "Explodo hit Ron! Ron's stats: HP: 1"
      else
        puts "invalid input"
      end

      # then AI player does a turn
      # b. Opponent casts spell. If player's charm points or hit points reach 0, go to combat over screen (8c). Otherwise, go to (8)
      opponent_charm = opponent.charms.sample
      player_charm_counter += opponent_charm.points
      puts "Ron cast Magic Missile! Your stats: HP: 7"
    end

    # c. Combat over screen: show combat result (who won, how many power/popularity points they get, how many power/popularity points the opponent gets)
    if player_charm_counter == player.charm_points
      puts "Ron smittened you!"
    else
      puts "You smittened ron!"
    end
    # update player stats and opponent stats

  end

  # 10. Game over screen: if win condition is met, show the outcome and some story text
  def display_game_over
    # todo
  end

  def run
    self.game = Game.new # start a new game

    display_welcome # call welcome method

    name_input = prompt_for_player_name # prompt for player to enter name

    player = Player.new(name_input) # create new player instance
    self.game.player = player

    self.game.initialize_leaderboard

    display_player_info(self.game.player) # display welcome message with player details

    until self.game.won? || self.game.lost?
      self.game.turn # take a turn
    end

    puts "You won! You're the most popular kid in school."

  end

end
