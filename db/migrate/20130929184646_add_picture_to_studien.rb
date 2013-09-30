class AddPictureToStudien < ActiveRecord::Migration
  def change
    add_column :studien, :picture, :string
  end
end
