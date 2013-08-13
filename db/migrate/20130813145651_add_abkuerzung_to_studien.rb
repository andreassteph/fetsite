class AddAbkuerzungToStudien < ActiveRecord::Migration
  def change
    add_column :studien, :abkuerzung, :string
  end
end
