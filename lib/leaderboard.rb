class Leaderboard

  attr_reader :contenders

  def initialize(player, classmates)
    @contenders = []
    @contenders += [player]
    @contenders += classmates
  end

  # gets the victories and friends of a character
  def score(contender)
    self.contenders.include?(contender) ? "#{contender.name} |\n #{contender.friends} friends on WitchBook | #{contender.victories} notches on their wand" : "This contender doesn't seem to exist"
  end

  def display_all
    scores = "|||Leaderboard|||\n"
    self.contenders.each { |contender| scores = scores + "#{score(contender)}" + "\n" }
    puts scores
  end

end
