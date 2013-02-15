class CreateBeispiele < ActiveRecord::Migration
  def up
    create_table :beispiele do |t|
      t.string :name
      t.text  :desc
      t.integer :lva_id
      t.timestamps
    end
    add_attachment :beispiele, :file
    Beispiel.create_translation_table!({
      :desc => :text,
    })
    add_column :beispiel_translations, :beispiele_id, :integer
    remove_column :beispiel_translations, :beispiel_id
  end
  def down
    Beispiel.drop_translation_table! #:migrate_data => true
    drop_table :beispiele
    
  end
end
