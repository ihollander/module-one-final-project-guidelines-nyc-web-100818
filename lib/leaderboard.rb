class Leaderboard

  attr_reader :contenders

  def initialize(player, classmates)
    @contenders = []
    @contenders += [player]
    @contenders += classmates
  end

  # gets the victories and friends of a character
  def score(contender)
    print "#{contender.name}: "
    sleep(0.1)
    contender.friends.times {print "#{Pastel.new.red("❤︎")}"}
    print " | " if contender.friends > 0 && contender.victories > 0
    sleep (0.1)
    contender.victories.times {print "#{Pastel.new.red("⚡")}"}
    puts " "
    sleep(0.1)
  end

  def display_all
    UI.delimiter_magenta("^")
    w = UI.get_win_width
    (w/2 - 7).times {print " "}
    puts "|Leaderboard|\n"
    (w/2 - 21).times {print " "}
    puts "#{Pastel.new.red("❤︎")} friends on WitchBook || #{Pastel.new.red("⚡")} notches on wand"
    self.contenders.each { |contender| score(contender)}
  end

end
