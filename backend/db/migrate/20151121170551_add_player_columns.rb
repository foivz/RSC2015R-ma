class AddPlayerColumns < ActiveRecord::Migration
  def change
    add_column :users, :game_id, :integer
    add_column :users, :tame_id, :integer
    add_column :users, :ready, :boolean, default: false
    add_column :users, :latitude, :decimal, precision: 8, scale: 6
    add_column :users, :longitude, :decimal, precision: 9, scale: 6
    add_column :users, :alive, :boolean, default: true
  end
end
