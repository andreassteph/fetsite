class AddWikiToThemengruppen < ActiveRecord::Migration
  def change
    add_column :themengruppen, :wiki_default, :boolean
  end
end
