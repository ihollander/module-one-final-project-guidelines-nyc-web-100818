class SpellCombat
  include DisplayMethods

  attr_accessor :player, :classmate, :player_damage, :classmate_damage, :whose_turn, :easter_egg

  def initialize(player, classmate)
    @player = player
    @classmate = classmate
    @player_damage = 0
    @classmate_damage = 0
    @whose_turn = [@player.name, @classmate.name].sample
    @easter_egg = false
  end

  def display_combat_screen(last_action)
    clear_screen
    display_stats # stats
    puts ""
    puts last_action # Current action
    puts ""
    if over?
      display_results
    else
      puts "It's #{self.whose_turn}'s turn..."
    end
    puts ""
    # Prompt box for player actions (spells)
  end

  def display_stats
    player_damage = "⚡" * self.player_damage
    classmate_damage = "⚡" * self.classmate_damage
    puts "#{self.player.name} damage taken: #{player_damage}".ljust(SCREEN_SIZE[0] / 2) + "#{self.classmate.name} damage taken: #{classmate_damage}".ljust(SCREEN_SIZE[0] / 2)
  end

  def display_results
    result = self.player_damage >= self.player.hit_points ? "#{self.classmate.name} defeated you!" : "You defeated #{self.classmate.name}!"
    puts result
  end

  def display_spell_effect(spell, caster, target)
    result = "#{caster.name} cast #{spell.name}!\n"
    result += "#{spell.name}: #{spell.description}.\n"
    result += "#{target.name} takes #{spell.hit_points} damage."
    result
  end

  def calculate_results
    self.player_damage >= self.player.hit_points ? self.classmate.victories += 1 : self.player.victories += 1
  end

  def start
    last_action = "You have entered a wizard duel with #{self.classmate.name}!"
    display_combat_screen(last_action)

    until over?
      display_combat_screen(last_action)
      if self.whose_turn == self.player.name
        spell = self.player.prompt_for_spell
        if ["Avada Kedavra", "Crucio", "Imperio"].include?(spell.name) # exit combat and go to easter egg screen
          self.easter_egg = true
        else
          self.classmate_damage += spell.hit_points
          last_action = display_spell_effect(spell, self.player, self.classmate)
          self.whose_turn = self.classmate.name
        end
      else
        sleep(3)
        spell = self.classmate.spells.sample
        self.player_damage += spell.hit_points
        last_action = display_spell_effect(spell, self.classmate, self.player)
        self.whose_turn = self.player.name
      end
    end

    calculate_results
    display_combat_screen(last_action)
  end

  def start_ai_round
    until over?
      if self.whose_turn == self.player.name
        player_spell = self.player.spells.sample
        self.classmate_damage += player_spell.hit_points
        self.whose_turn = self.classmate.name
      else
        classmate_spell = self.classmate.spells.sample
        self.player_damage += classmate_spell.hit_points
        self.whose_turn = self.player.name
      end
    end
    calculate_results
  end

  def over?
    self.player_damage >= self.player.hit_points || self.classmate_damage >= self.classmate.hit_points || self.easter_egg
  end

end
