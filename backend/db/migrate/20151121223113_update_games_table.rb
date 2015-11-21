class UpdateGamesTable < ActiveRecord::Migration
  def change
    add_column :games, :players_in, :boolean, default: false
    add_column :games, :playing, :boolean, default: false
  end
end
