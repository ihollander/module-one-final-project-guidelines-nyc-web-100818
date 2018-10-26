class Character < ActiveRecord::Base
  belongs_to :house
  has_many :quotes
  has_many :spellbooks
  has_many :spells, through: :spellbooks

end
