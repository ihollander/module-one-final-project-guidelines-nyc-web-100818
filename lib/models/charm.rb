class Charm < ActiveRecord::Base
  has_many :characters, through: :character_charms

end
