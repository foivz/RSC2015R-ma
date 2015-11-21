class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :type
      t.integer :duration
      t.string :pin
      t.integer :field_id
      t.integer :team_a_id
      t.integer :team_b_id

      t.timestamps null:false
    end
  end
end
