class ChangeFieldsColumnNull < ActiveRecord::Migration
  def change
    change_column :fields, :occupied, :boolean, null: true
  end
end
