class AddWikiToThema < ActiveRecord::Migration
  def change
    add_column :themen, :wikiname, :string
    add_column :themen, :wikiformat, :integer
    add_column :themen, :hidelink, :boolea
  end
end
