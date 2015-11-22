class ChangeTeamScore < ActiveRecord::Migration
  def change
    change_column :teams, :score, :integer, default: 0
  end
end
