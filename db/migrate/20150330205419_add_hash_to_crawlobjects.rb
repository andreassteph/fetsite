class AddHashToCrawlobjects < ActiveRecord::Migration
  def up
    change_table :crawlobjects do |t|
      t.string :objhash, :index=>true
      t.string :objhash2, :index=>true

     end
  end
  def down
    remove_column :crawlobjects, :objhash
    remove_column :crawlobjects, :objhash2

   end
end
