class AddFlagsToBeispiel < ActiveRecord::Migration
  def change
    add_column :beispiele, :flag_badquality, :boolean
    add_column :beispiele, :flag_duplicate, :boolean
    add_column :beispiele, :flag_delete, :boolean
    add_column :beispiele, :flag_goodquality, :boolean
    add_column :beispiele, :lecturer_id, :integer
    add_index :beispiele,  :flag_badquality
    add_index :beispiele, :flag_duplicate
    add_index :beispiele, :flag_delete
    add_index :beispiele, :flag_goodquality

  end
end
