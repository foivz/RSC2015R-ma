class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, null: false
      t.string :password_digest, null: false
      t.uuid :access_token, null: false
      t.integer :role, null: false
      t.boolean :active, null: false

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
    add_index :users, :access_token, unique: true
  end
end
