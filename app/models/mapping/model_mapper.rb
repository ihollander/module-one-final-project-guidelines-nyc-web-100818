module ModelMapper

  # returns a new hash from API mapped to arguments for Spell.new
  def map_to_spell(spell_hash)
    charm_points = ["Charm","Enchantment","Spell"].include?(spell_hash["type"]) ? rand(0..10) : 0
    hit_points = ["Hex","Curse","Jinx"].include?(spell_hash["type"]) ? rand(0..10) : 0

    {
      name: spell_hash["spell"],
      description: spell_hash["effect"],
      spell_type: spell_hash["type"],
      charm_points: charm_points,
      hit_points: hit_points
    }
  end

  # returns a new hash from API mapped to arguments for Character.new
  def map_to_character(character_hash)
    patronus = !character_hash["patronus"] || character_hash["patronus"] == "" ? MY_ANIMAL_FAKER.sample : character_hash["patronus"]
    occupation = character_hash["hogwartsStudent"] ? "student" : "staff"
    pet = ["cat", "owl", "toad", "rat"].sample

    {
      name: character_hash["name"],
      wand: character_hash["wand"]["core"],
      patronus: patronus,
      gender: character_hash["gender"],
      birth_year: character_hash["yearOfBirth"],
      occupation: occupation,
      pet: pet,
      hit_points: 1,
      charm_points: 1
    }
  end
end
