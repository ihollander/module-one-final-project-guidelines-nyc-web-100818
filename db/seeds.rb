class SeedRunner
  include ModelMapper

  def run_seed
    api = ApiCommunicator.new

    # seed houses manually...
    puts "Seeding houses..."
    house_hashes = [{name: "Gryffindor",
     color: "Scarlet & Gold",
     mascout: "Lion",
     head_of_house: "Minerva McGonagall",
     house_ghost: "Nearly Headless Nick",
     founder: "Goderic Gryffindor",
     values: "Courage, Bravery, Nerve and Chivalry"
     },

    {name: "Slytherin",
     color: "Green & Silver",
     mascout: "Serpent",
     head_of_house: "Severus Snape",
     house_ghost: "The Bloody Baron",
     founder: "Salazar Slytherin",
     values: "Ambition, Cunning, Leadership and Resourcefulness"
    },

    {name: "Ravenclaw",
     color: "Blue & Bronze",
     mascout: "Eagle",
     head_of_house: "Fillius Flitwick",
     house_ghost: "The Grey Lady",
     founder: "Rowena Ravenclaw",
     values: "Intelligence, Creativity, Learning and Wit"
    },

    {name: "Hufflepuff",
     color: "Yellow & Black",
     mascout: "Badger",
     head_of_house: "Pomona Sprout",
     house_ghost: "The Fat Friar",
     founder: "Helga Hufflepuff",
     values: "Hard work, Patience, Justice and Loyalty"
    }]
    house_hashes.each do |house_hash|
      House.create(house_hash)
    end

    # TODO: add more nice things
    puts "Seeding charms..."
    charm_hashes = [{dialog: "It's very nice to meet you.", points: 1},
    {dialog: "I solemnly swear I am up to no good.", points: 5},
    {dialog: "You smell lovely!", points: 2},
    {dialog: "Would you like to go to the Triwizard Tournament Ball with me?", points: 5},
    {dialog: "I mean, it's sort of exciting, isn't it, breaking the rules?", points: 3},
    {dialog: "You want to visit Moaning Myrtle sometime?", points: 1},
    {dialog: "Riddikulus!", points: 5},
    {dialog: "You have your mother's eyes.", points: 1},
    {dialog: "Your patronus is very cool!", points: 2},
    {dialog: "Do you want to exchange chocolate frog cards?", points: 3},
    {dialog: "Cheering! [A charm that makes the person happy and giddy]", points: 5},
    {dialog: "What is your favorite candy from Honeydukes?", points: 3},
    {dialog: "Let's go play Quidditch together!", points: 4},
    {dialog: "I like Professor Snape.", points: 3},
    {dialog: "I love your pet! What is his/her name?", points: 2}]
    charm_hashes.each do |charm_hash|
      Charm.create(charm_hash)
    end

    # get spells hash from API
    puts "Seeding spells..."
    spell_hashes = api.get_spells
    spell_hashes.each do |spell_hash|
      spell_args = map_to_spell(spell_hash) # map hash from API to our Spell class
      spell = Spell.new(spell_args)
      spell.save
    end

    # get characters hash from API
    puts "Seeding characters..."
    character_hashes = api.get_characters
    character_hashes.each do |character_hash|
      character_args = map_to_character(character_hash) # map hash from API to our Character class
      character = Character.new(character_args)
      character.save

      # Assign 4 random spells to character
      4.times do
        spell = Spell.all.sample
        spellbook = Spellbook.new(spell_id: spell.id)
        character.spellbooks << spellbook
      end

      # Assign character to a house based on house name
      house = House.find_by(name: character_hash["house"])
      if house
        house.characters << character
      end
    end

    # get quotes hash from API
    puts "Seeding quotes..."
    quote_hashes = api.get_quotes
    quote_hashes.each do |quote_hash|
      character = Character.find_by(name: quote_hash["character"])
      if character
        quote = Quote.new(dialog: quote_hash["quote"], character_id: character.id)
        character.quotes << quote
      end
    end

    puts "Seeding complete!"
  end

end

sr = SeedRunner.new
sr.run_seed
