class CreateIndividualMessages < ActiveRecord::Migration
  def change
    create_table :individual_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :message
      t.timestamps null: false
    end
  end
end
