class Character < ActiveRecord::Base
  belongs_to :house
  has_many :quotes
  has_many :spellbooks
  has_many :spells, through: :spellbooks
  has_many :charms, through: :character_charms

end
