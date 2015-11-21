class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :count
      t.integer :game_id
      t.decimal :latitude, precision: 8, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.integer :score

      t.timestamps null: false
    end
  end
end
