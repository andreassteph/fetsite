class AddIcon < ActiveRecord::Migration
  def change
    add_column :themengruppen, :icon, :string
    add_column :rubriken, :icon, :string
    add_column :themen, :icon, :string
  end

end
