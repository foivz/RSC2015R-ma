class AddFieldsColumn < ActiveRecord::Migration
  def change
    add_column :fields, :longitude_se, :decimal, precision: 9, scale: 6
  end
end
