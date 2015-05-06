class AddVisibleToStudien < ActiveRecord::Migration
  def change
    add_column :studien, :visible, :boolean
  end
end
