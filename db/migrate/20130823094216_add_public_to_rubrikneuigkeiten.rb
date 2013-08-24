class AddPublicToRubrikneuigkeiten < ActiveRecord::Migration
  def up
  add_column :rubriken, :public,:boolean
  Rubrik.update_all(:public => :true)
  end
  def down
  remove_column :rubriken, :public
  end
end
