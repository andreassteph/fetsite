class AddPublicToThemengruppe < ActiveRecord::Migration
  def change
    add_column :themengruppen, :public, :boolean
  end
end
