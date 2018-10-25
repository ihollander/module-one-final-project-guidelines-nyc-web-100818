# UI - prompts, display messages, etc
class UI
  attr_accessor :game

  def display_welcome
    # puts ColorizedString["This is blue"].colorize(:light_blue)
    tty_font_print("Welcome to Hogwarts!")
    sleep(1)

    delimiter_magenta("^")
    puts "\n This is a game where you befriend or defeat your fellow Hogwarts classmates to  become the coolest kid in class!"
    continue_prompt_magenta
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

    clear_screen

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

  def clear_screen
    IO.popen("clear", "w")
  end

  def tty_font_print(text)
    #TODO center text
    sp_text = text.split(" ")
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    sp_text.each do |t|
      puts pastel.cyan(font.write(t, letter_spacing: 0))
    end
  end

  def get_win_width
    row, column = $stdin.winsize
    column
  end

  def continue_prompt_magenta
    continue = "(enter to continue)"

    w = get_win_width

    ((w / 2) - (continue.length / 2) - 1).times { print Pastel.new.magenta("^") }

    print Pastel.new.magenta(continue)

    ((w / 2) - (continue.length / 2)).times { print Pastel.new.magenta("^") }

    gets.chomp
  end

  def delimiter_magenta(character)
    w = get_win_width
    w.times { print Pastel.new.magenta(character) }
  end

end
