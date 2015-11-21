class AddFieldsColumnNotNull < ActiveRecord::Migration
  def change
    change_column_null :fields, :longitude_se, false
  end
end
