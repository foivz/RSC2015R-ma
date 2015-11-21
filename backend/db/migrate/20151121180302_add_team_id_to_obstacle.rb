class AddTeamIdToObstacle < ActiveRecord::Migration
  def change
    add_column :obstacles, :team_id, :integer
  end
end
