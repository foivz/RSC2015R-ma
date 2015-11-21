class CreateTeamMessages < ActiveRecord::Migration
  def change
    create_table :team_messages do |t|
      t.integer :user_id
      t.integer :team_id
      t.text :message
      t.timestamps null: false
    end
  end
end
