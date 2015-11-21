class RenameFieldsColumns < ActiveRecord::Migration
  def self.up
    rename_column :fields, :latitude_top, :latitude_nw
    rename_column :fields, :longitude_top, :longitude_nw
    rename_column :fields, :latitude_bottom, :latitude_se
  end

  def self.down
    rename_column :fields, :latitude_nw, :latitude_top
    rename_column :fields, :longitude_nw, :longitude_top
    rename_column :fields, :latitude_se, :latitude_bottom
  end
end
