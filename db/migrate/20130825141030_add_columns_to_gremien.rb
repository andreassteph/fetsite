class AddColumnsToGremien < ActiveRecord::Migration
  def change
    add_column :gremien, :geschlecht, :string
    add_column :gremien, :thema_id, :integer
  end
end
