class AddDateToBeispiel < ActiveRecord::Migration
  def change
    add_column :beispiele, :datum, :date
  end
end
