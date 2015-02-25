class AddStickyToThema < ActiveRecord::Migration
  def change
    add_column :themen, :sticky_startpage, :boolean
    add_column :themen, :sticky_intern, :boolean
    add_column :themengruppen, :sticky_startpage, :boolean
    add_column :themengruppen, :sticky_intern, :boolean
    add_column :galleries, :sticky_startpage, :boolean
  end
end
