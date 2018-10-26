class CharacterCharms < ActiveRecord::Base
  belongs_to :character
  belongs_to :charm

end
