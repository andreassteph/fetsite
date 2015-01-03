class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :typ, :default=>0
      t.string :name
      t.text :text
      t.string :etherpadkey, :default=>""
      t.references :parent,:polymorphic=>{:default=>'Thema'}
      t.timestamps
    end
    add_index :documents, :parent_id
    add_index :documents, :parent_type

  end
end
