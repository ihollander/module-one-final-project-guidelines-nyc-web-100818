class AddColumnToHouse < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :mascout, :string
    add_column :houses, :head_of_house, :string
    add_column :houses, :house_ghost, :string
    add_column :houses, :founder, :string
    add_column :houses, :values, :string
  end
end
