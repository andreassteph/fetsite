class AddIndexForNeuigkeiten < ActiveRecord::Migration
  def change
    add_index :neuigkeiten, :rubrik_id
    add_index :neuigkeiten, :cache_is_published
    add_index :calentries, [:object_type, :object_id]
    add_index :attachments, [:parent_type, :parent_id]
    add_index :attachments, [:flag_titlepic, :parent_type, :parent_id]
    add_index :rubriken, :public
  end

end
