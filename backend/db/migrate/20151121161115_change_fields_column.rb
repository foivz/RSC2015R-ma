class ChangeFieldsColumn < ActiveRecord::Migration
  def change
    change_column :fields, :latitude_se, :decimal, precision: 8, scale: 6, null: false
  end
end
