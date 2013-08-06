class AddIdToThemen < ActiveRecord::Migration
  def change
		add_column :themen, :themengruppe_id, :integer
    add_column :attachments, :thema_id, :integer
		add_column :fragen, :thema_id, :integer
  end
end
