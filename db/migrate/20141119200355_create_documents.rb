class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :typ
      t.string :name
      t.text :text
      t.string :etherpadkey
      t.references{polymorphic} :parent

      t.timestamps
    end
  end
end
