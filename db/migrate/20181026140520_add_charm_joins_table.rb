class AddCharmJoinsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :character_charms do |t|
      t.integer :charm_id
      t.integer :character_id
    end
  end
end
