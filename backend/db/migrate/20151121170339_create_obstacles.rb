class CreateObstacles < ActiveRecord::Migration
  def change
    create_table :obstacles do |t|
      t.decimal :latitude, precision: 8, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.integer :type
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
