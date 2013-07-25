class CreateBeispiele < ActiveRecord::Migration
  def up
    create_table :beispiele do |t|
      t.string :name
      t.text  :desc
      t.integer :lva_id
      t.timestamps
      t.string :beispieldatei
    end
    
  end
  def down
    # Beispiel.drop_translation_table! #:migrate_data => true
    drop_table :beispiele
    
  end
end
