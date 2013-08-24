class AddObjectToCalentries < ActiveRecord::Migration
  def up
      add_column :calentries,:object_id, :integer
      add_column :calentries,:object_type, :string
      add_column :calentries, :public, :boolean
      Calentry.update_all(:public => :true)
  end
  
  def down
		remove_column :calentries, :object_id
		remove_column :calentries,:object_type
		remove_column :calentries,:public
  end
end
