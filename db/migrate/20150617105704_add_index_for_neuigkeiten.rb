class AddIndexForNeuigkeiten < ActiveRecord::Migration
  def up
    add_index :neuigkeiten, :rubrik_id
    add_index :calentries, [:object_type, :object_id]
    add_index :attachments, [:parent_type, :parent_id]
    add_index :attachments, [:flag_titlepic, :parent_type, :parent_id]
    add_index :neuigkeit_translations, :neuigkeit_id 
  end

  def down
  end
end
