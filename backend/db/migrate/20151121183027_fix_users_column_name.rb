class FixUsersColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :tame_id, :team_id
  end
end
