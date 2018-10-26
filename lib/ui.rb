# UI - prompts, display messages, etc
class UI
  include DisplayMethods

  attr_accessor :game

  def display_welcome
    tty_font_print("Welcome to Hogwarts!")
    sleep(SLEEP_TIME)
    display_delimiter_magenta("^","")
<<<<<<< HEAD
    print "\nIn Howgarts, you can choose to become the most "
    print PASTEL.yellow("powerful")
    print " student or the most "
    print PASTEL.yellow("popular")
    puts " student."
    sleep(2)
    print "\nYou need to defeat or charm "
    print PASTEL.yellow("THREE")
    puts " of your fellow students or professor to win."
    sleep(2)
=======
    puts "\nIn Howgarts, you can choose to become the most powerful student or the most popular student."
    sleep(SLEEP_TIME)
    puts "\nYou need to defeat or charm THREE of your fellow students or professor to win."
    sleep(SLEEP_TIME)
>>>>>>> charms_fix
    puts "\nMake your choices wisely."
    sleep(SLEEP_TIME)
    display_delimiter_magenta("^","Press [ENTER] to continue")
    gets # wait for enter
  end

  def display_game_over
    clear_screen
    if self.game.won?
      display_delimiter_magenta("^","")
      tty_font_print_end_page("Congratulations!")
      tty_font_print_end_page("You Won!")
    elsif self.game.easter_egg
      display_delimiter_magenta("^","")
      tty_font_print_end_page("Welcome")
      tty_font_print_end_page("to")
      tty_font_print_end_page("Azkaban")
      tty_font_print_end_page("GAME OVER")
    else
      display_delimiter_magenta("^","")
      tty_font_print_end_page("You  are")
      tty_font_print_end_page("neither  popular")
      tty_font_print_end_page("nor  powerful")
      tty_font_print_end_page("GAME OVER")
    end
    display_delimiter_magenta("^","Press [ENTER] to continue")
    gets # wait for enter
    disolve_screen(SCREEN_SIZE[1],0.01) # call from display_methods
    self.game.lboard.display_all
    display_delimiter_magenta("^","Press [ENTER] to continue")
    gets # wait for enter
    disolve_screen(SCREEN_SIZE[1],0.01) # call from display_methods
  end

  def run
    clear_screen # call from display_methods
    UI.display_logo
    disolve_screen(SCREEN_SIZE[1],0.01) # call from display_methods
    display_welcome # display welcome message
    name_input = ask("Enter your name: ") # prompt for player to enter name
    player = Player.new(name_input) # create new player instance
    if Player.find_by(name: name_input)
      player.id = Player.find_by(name: name_input).id
    else
      player.save
    end
    player.get_random_spells
    player.get_all_charms
    player.display_intro # display welcome message with player details
    display_delimiter_magenta("^","(Sorting Hat working its magic... Press [ENTER] to continue)")
    gets
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
