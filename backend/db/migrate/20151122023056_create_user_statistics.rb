class CreateUserStatistics < ActiveRecord::Migration
  def change
    create_table :user_statistics do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :duration_alive
      t.boolean :died
      t.boolean :won

      t.timestamps null: false
    end
  end
end
