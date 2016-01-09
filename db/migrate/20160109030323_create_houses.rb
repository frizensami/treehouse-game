class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.integer :floor_start
      t.integer :floor_end
      t.string :description
      t.string :color

      t.timestamps null: false
    end
  end
end
