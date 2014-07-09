class AddColor < ActiveRecord::Migration
  def change
    add_column :rubriken, :color, :integer
  end

end
