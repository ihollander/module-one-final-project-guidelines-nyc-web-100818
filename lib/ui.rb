# UI - prompts, display messages, etc
class UI
  include DisplayMethods

  attr_accessor :game

  def display_welcome
    # puts ColorizedString["This is blue"].colorize(:light_blue)
    tty_font_print("Welcome to Hogwarts!")
    sleep(2)

    UI.delimiter_magenta("^")
    puts "\n In Howgarts you can choose to become the most powerful student or the most popular student."
    sleep(2)
    puts "\n You need to defeat or charm 3 of your fellow students or professor to win."
    sleep(2)
    puts "\n Make your choices wisely."
    sleep(2)
    UI.continue_prompt_magenta
  end

  def prompt_for_player_name
    print "\n Enter your name: "
    gets.chomp
  end

  def display_player_info(player)
    puts "\n #{player.name}, Olivanders has customized a wand for you! It's made of #{player.wand}."
    sleep(2)
    puts "\n Your pet: #{player.pet}! Your patronus: #{player.patronus}!"
    sleep(2)
    sortinghat_prompt_magenta
    sleep(2)
    puts "\n Congratulation!You have been sorted into #{player.house.name} House!"
    sleep(2)
    puts "\n #{player.house.founder} founded the House hoping to find young wizards that have #{player.house.values}."
    sleep(2)
    puts "\n Your Head of House is #{player.house.head_of_house}."
    puts "\n Your House ghost is #{player.house.house_ghost} "
    house_color(player)
    UI.continue_prompt_magenta
  end

  def house_color(player)
    house_color = player.house.color
    # binding.pry
    house_color_split = house_color.split(" & ")
    if house_color_split[0] == "Scarlet"
      print "Your House colors are " + Pastel.new.black.on_red(house_color_split[0]) + " & " + Pastel.new.red.on_yellow(house_color_split[1])
    elsif house_color_split[0] == "Green"
      print "Your House colors are " + Pastel.new.black.on_green(house_color_split[0]) + " & " + Pastel.new.black.on_white(house_color_split[1])
    elsif house_color_split[0] == "Blue"
      print "Your House colors are " + Pastel.new.on_blue(house_color_split[0]) + " & " + Pastel.new.black.on_yellow(house_color_split[1])
    else house_color_split[0] == "Yellow"
      print "Your House colors are " + Pastel.new.black.on_yellow(house_color_split[0]) + " & " + Pastel.new.black.on_white(house_color_split[1])
    end

  end

  def display_game_over
    if self.game.won?
      puts "You won!"
    else
      puts "You lost :("
    end
  end

  def run

    clear_screen # call from display_methods

    UI.display_logo

    disolve_screen(SCREEN_SIZE[1],0.01) # call from display_methods

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

  def tty_font_print(text)
    #TODO center text
    sp_text = text.split(" ")
    font = TTY::Font.new(:standard)
    sp_text.each do |t|
      puts PASTEL.cyan(font.write(t, letter_spacing: 0))
    end
  end

  def UI.get_win_width
    row, column = $stdin.winsize
    column
  end

  def UI.continue_prompt_magenta
    puts " "
    continue = "(enter to continue)"

    w = UI.get_win_width

    ((w / 2) - (continue.length / 2) - 1).times { print PASTEL.magenta("^") }

    print PASTEL.magenta(continue)

    ((w / 2) - (continue.length / 2)).times { print PASTEL.magenta("^") }

    (w/2 - 1).times { print " " }
    puts Pastel.new.yellow("⚡")

    gets.chomp
  end

  def UI.delimiter_magenta(character)
    puts " "
    w = UI.get_win_width
    w.times { print PASTEL.magenta(character) }
    (w/2).times { print " " }
    puts PASTEL.yellow("⚡")
  end

  def sortinghat_prompt_magenta
    continue = "(Sorting Hat working its magic)"

    w = UI.get_win_width

    ((w / 2) - (continue.length / 2) - 1).times { print Pastel.new.magenta("^") }

    print Pastel.new.magenta(continue)

    ((w / 2) - (continue.length / 2)).times { print Pastel.new.magenta("^") }
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
