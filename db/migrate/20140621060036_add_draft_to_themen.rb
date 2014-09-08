class AddDraftToThemen < ActiveRecord::Migration
  def change
    add_column :themen, :hideattachment, :boolean
    add_column :themen, :isdraft, :boolean
  end
end
