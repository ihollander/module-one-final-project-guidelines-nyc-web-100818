# UI - prompts, display messages, etc
class UI
  include DisplayMethods

  attr_accessor :game

  def display_welcome
    tty_font_print("Welcome to Hogwarts!")
    sleep(2)
    display_delimiter_magenta("^","")
    puts "\nIn Howgarts, you can choose to become the most powerful student or the most popular student."
    sleep(2)
    puts "\nYou need to defeat or charm THREE of your fellow students or professor to win."
    sleep(2)
    puts "\nMake your choices wisely."
    sleep(2)
    display_delimiter_magenta("^","Press [ENTER] to continue")
    gets # wait for enter
  end

  def display_game_over
    if self.game.won?
      puts "You won!"
    else
      puts "You lost :("
    end
  end

  def run
    disolve_screen(SCREEN_SIZE[1],0.02) # clear the screen (call from DisplayMethods)
    display_welcome # display welcome message
    name_input = ask("Enter your name: ") # prompt for player to enter name
    player = Player.new(name_input) # create new player instance
    player.display_intro # display welcome message with player details

    player.house.display_info # display house info

    display_delimiter_magenta("^","Press [ENTER] to continue")
    gets # wait for enter

    self.game = Game.new(player)
    self.game.play

    display_game_over
  end

  def tty_font_print(text)
    #TODO center text
    sp_text = text.split(" ")
    font = TTY::Font.new(:standard)
    sp_text.each do |t|
      puts PASTEL.cyan(font.write(t, letter_spacing: 0))
    end
  end

# def house_color(player)
#   house_color = player.house.color
#   binding.pry
#   house_color_split = house_color.split(" & ")
#   if house_color_split[0] == "Scarlet"
#     print Pastel.new.on_red(house_color)
#   end
# end



end
