class AddPreferredthemeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferredtheme, :string
  end
end
