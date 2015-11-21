class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.decimal :latitude_top, precision: 8, scale: 6, null: false
      t.decimal :longitude_top, precision: 9, scale: 6, null: false
      t.decimal :latitude_bottom, precision: 8, scale: 6, null: false
      t.decimal :latitude_bottom, precision: 9, scale: 6, null: false
      t.boolean :occupied, null: false

      t.timestamps null: false
    end
  end
end
