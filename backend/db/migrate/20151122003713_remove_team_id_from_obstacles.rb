class RemoveTeamIdFromObstacles < ActiveRecord::Migration
  def change
    remove_column :obstacles, :team_id
  end
end
