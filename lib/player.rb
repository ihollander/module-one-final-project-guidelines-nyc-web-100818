class Player < Character
  include DisplayMethods

  attr_accessor :charms, :spells, :friends, :victories, :classmates_faced

  # TODO: update to save character to database... find/create by name
  def initialize(name)
    super(name: name)
    self.hit_points = 10
    self.charm_points = 10
    self.house_id = House.all.sample.id
    self.wand = Character.all.select{|c| !c.wand.start_with?(" ") }.sample.wand
    self.pet = ["cat", "owl", "toad", "rat"].sample
    self.patronus = MY_ANIMAL_FAKER.sample
    @classmates_faced = []
    self.friends = 0
    self.victories = 0
  end

  def get_random_spells
    @spells = Spell.all.sample(4)
    easter_egg_spell = Spell.new(name: ["Avada Kedavra", "Crucio", "Imperio"].sample, description: "An unforgivable charm. People have been sent to Azkaban for less!")
    @spells << easter_egg_spell
  end

  def get_all_charms
    @charms = Charm.all
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
    intro_array << "\nYour pet #{self.pet} has come with you! You feel a kinship with your Patronus, the #{self.patronus}!"
    intro_array.each do |line|
      puts line
      sleep(SLEEP_TIME)
    end
  end

end
