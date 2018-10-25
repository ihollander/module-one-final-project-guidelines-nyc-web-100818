class Player < Character

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

  def display_spell_options
    spell_options = []
    self.spells.each_with_index{|spell, index|
      spell_options << "[#{index + 1}] #{spell.name} - #{spell.description}"
    }
    "Pick a spell: \n#{spell_options.join("\n")}"
  end

  def prompt_for_spell
    spell = nil
    until spell
      puts self.display_spell_options
      spell_input = gets.chomp
      if valid_spell_input?(spell_input)
        spell = self.spells[spell_input.to_i - 1]
      else
        puts "Invalid input!"
      end
    end
    spell
  end

  def valid_spell_input?(input_string)
    spell_number = input_string.to_i
    spell_number.to_s == input_string && spell_number.between?(1, self.spells.length) # check valid number
  end

end
