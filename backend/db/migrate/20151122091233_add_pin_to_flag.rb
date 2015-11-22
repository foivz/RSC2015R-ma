class AddPinToFlag < ActiveRecord::Migration
  def change
    add_column :obstacles, :pin, :string
  end
end
