class AddExifToFoto < ActiveRecord::Migration
  def change
    add_column :fotos, :exif, :string
    add_column :fotos, :has_exif, :boolean
  end
end
