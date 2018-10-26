class Classmate < Character

  attr_accessor :charms, :friends, :victories

  def initialize(attributes)
    super(attributes)
    @charms = []
    @friends = 0
    @victories = 0
  end

  def display_intro
    puts "You meet #{self.name} in the hallway."
    puts "#{self.name} says hello! Some things you know about #{self.name}:"
    puts "They're followed by their #{self.pet} familiar."
    puts "They exude the strength of the #{self.patronus}."
    puts "They're sporting #{self.house.name} colors." if self.house
  end

end
