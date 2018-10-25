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

  def display_game_over
    if self.game.won?
      puts "You won!"
    else
      puts "You lost :("
    end
  end

  def run
    self.game = Game.new # start a new game

    display_welcome # display welcome message

    name_input = prompt_for_player_name # prompt for player to enter name

    player = Player.new(name_input) # create new player instance
    self.game.player = player

    self.game.initialize_leaderboard # player must be initialized before leaderboard can be initialized

    display_player_info(self.game.player) # display welcome message with player details

    until self.game.over?
      self.game.turn # take a turn
    end

    display_game_over

  end

end
