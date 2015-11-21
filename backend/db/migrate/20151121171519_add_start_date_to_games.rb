class AddStartDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :start_date, :datetime
  end
end
