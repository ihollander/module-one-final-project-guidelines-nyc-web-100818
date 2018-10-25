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
    clear_screen
      if self.game.won?
        display_delimiter_magenta("^","")
        tty_font_print_end_page("Congratulation! You Won!")
      else
        display_delimiter_magenta("^","")
        tty_font_print_end_page("You  are  neither")
        tty_font_print_end_page("popular  nor  powerful")
      end
    end

  def run
    clear_screen # call from display_methods
    UI.display_logo
    disolve_screen(SCREEN_SIZE[1],0.01) # call from display_methods
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

  def tty_font_print_end_page(text)
    #TODO center text
    font = TTY::Font.new(:standard)
    puts PASTEL.yellow(font.write(text))
  end

# def house_color(player)
#   house_color = player.house.color
#   binding.pry
#   house_color_split = house_color.split(" & ")
#   if house_color_split[0] == "Scarlet"
#     print Pastel.new.on_red(house_color)
#   end
# end

  def self.display_logo
    if SCREEN_SIZE[1] >= 76
      logo_ascii = [
  '.      .           /\      .:  *       .       .                 .',
  '            *    .    .      .     .     *   .        #            .',
  ':          .    /      \  _ ._______________                    #   .',
  '  |             `.+-~~-+."/." `.^^^^^^^^\~~~~~\.           O          .',
  '.    -*-   . .   |u--.|  /     \~~~~~~~|~~~~~|',
  '  |              |   u|."       `." "  |" " "|        O               .',
  ':            .   |.u-./ _..---.._ \" " | " " |',
  '-*-            * |    ~-|U U U U|-~____L_____L_      #          #     .',
  ':         .   .  |.-u.| |..---..|"//// ////// /\       .             .',
  '     .  *        |u   | |       |// /// // ///==\     / \      O   .',
  '.          :     |.--u| |..---..|//////~\////====\   /   \      .',
  ' .               | u  | |       |~~~~/\u |~~|++++| .`+~~~+"  .',
  '       .         |.-|~U~U~|---..|u u|u | |u ||||||   |  U|',
  '              /~~~~/-\---."     |===|  |u|==|++++|   |   |',
  '              |===| _ | ||.---..|u u|u | |u ||HH||U~U~U~U~|',
  '              |   |   | ||      |   |    _ __             |',
  '        ___                             | "  \\',
  '   ___  \ /  ___         ,"\_           | .-. \        /|',
  '   \ /  | |,"__ \  ,"\_  |   \          | | | |      ," |_   /|',
  ' _ | |  | |\/  \ \ |   \ | |\_|    _    | |_| |   _ "-. .-"," |_   _',
  '// | |  | |____| | | |\_|| |__    //    |     | ,"_`. | | "-. .-"," `. ,"\_',
  '\\\\_| |_," .-, _  | | |   | |\ \  //    .| |\_/ | / \ || |   | | / |\  \|   \\',
  ' `-. .-"| |/ / | | | |   | | \ \//     |  |    | | | || |   | | | |_\ || |\_|',
  '   | |  | || \_| | | |   /_\  \ /      | |`    | | | || |   | | | .---"| |',
  '   | |  | |\___,_\ /_\ _      //       | |     | \_/ || |   | | | |  /\| |',
  '   /_\  | |           //_____//       .||`      `._," | |   | | \ `-" /| |',
  '        /_\           `------"        \ |              `.\  | |  `._," /_\\',
  '                                       \|                    `.\\'
      ]
      logo_ascii.each do |line|
        puts Pastel.new.yellow(line)
      end
      gets
    end
end
end
