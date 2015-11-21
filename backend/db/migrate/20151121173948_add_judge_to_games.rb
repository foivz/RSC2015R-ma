class AddJudgeToGames < ActiveRecord::Migration
  def change
    add_column :games, :judge_id, :integer
  end
end
