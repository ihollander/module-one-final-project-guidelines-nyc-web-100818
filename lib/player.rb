class Player < Character
  include DisplayMethods

  attr_accessor :charms, :spells, :friends, :victories, :classmates_faced

  # TODO: update to save character to database... find/create by name
  def initialize(name)
    super(name: name)
    self.hit_points = 10
    self.charm_points = 10
    self.name = name
    self.house_id = House.all.sample.id
    self.wand = Character.all.sample.wand
    self.pet = ["cat", "owl", "toad", "rat"].sample
    self.patronus = MY_ANIMAL_FAKER.sample
    @spells = Spell.all.sample(4)
    @charms = Charm.all
    @classmates_faced = []
    self.friends = 0
    self.victories = 0
  end

  def prompt_for_spell
    spell_options = []
    input_options = []
    self.spells.each_with_index{|spell, index|
      input_options << "#{index + 1}"
      spell_options << "[#{index + 1}] #{spell.name} - #{spell.description}"
    }
    prompt = "Pick a spell: \n#{spell_options.join("\n")}"
    input = ask(prompt, input_options)
    self.spells[input.to_i - 1]
  end

  def display_intro
    intro_array = []
    intro_array << "\n#{self.name}, Olivanders has customized a wand for you! It's made of #{self.wand}."
    intro_array << "\nYour pet: #{self.pet}! Your patronus: #{self.patronus}!"
    intro_array.each do |line|
      puts line
      sleep(2)
    end

    display_delimiter_magenta("^","(Sorting Hat working its magic... Press [ENTER] to continue)")
    gets

    intro_array = []
    intro_array << "\nCongratulations! You have been sorted into #{self.house.name} House!"
    intro_array << "\n#{self.house.founder} founded the House hoping to find young wizards that have #{self.house.values}."
    intro_array << "\nYour Head of House is #{self.house.head_of_house}.\nYour House ghost is #{self.house.house_ghost}."
    intro_array.each do |line|
      puts line
      sleep(2)
    end
  end

end
