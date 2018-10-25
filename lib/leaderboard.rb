class Leaderboard
  include DisplayMethods

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
    contender.friends.times {print "#{PASTEL.red("❤︎")}"}
    print " | " if contender.friends > 0 && contender.victories > 0
    sleep (0.1)
    contender.victories.times {print "#{PASTEL.red("⚡")}"}
    puts " "
    sleep(0.1)
  end

  def display_all
    display_delimiter_magenta("^")
    w = SCREEN_SIZE[1]
    (w/2 - 7).times {print " "}
    puts "|Leaderboard|\n"
    (w/2 - 21).times {print " "}
    puts "#{PASTEL.red("❤︎")} friends on WitchBook || #{PASTEL.red("⚡")} notches on wand"
    self.contenders.each { |contender| score(contender)}
  end

end
