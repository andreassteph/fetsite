class AddDateToFoto < ActiveRecord::Migration
  def change
    add_column :fotos, :taken_at, :timestamp
  end
end
