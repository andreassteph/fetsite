class CreateCrawlobjects < ActiveRecord::Migration
  def change
    create_table :crawlobjects do |t|
      t.string :name
      t.text :text
      t.text :raw
      t.integer :objtype, :index=>true
      t.string :schematype
      t.string :crawlurl
      t.string :url
      t.timestamp :crawltime
      t.timestamp :published_at
      t.references :something, :polymorphic => true
      t.integer :parent_id, :index => true
      t.integer :lft, :null => false ,:index =>true
      t.integer :rgt, :null => false, :index => true
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0
      t.timestamps
    end
  end
end
