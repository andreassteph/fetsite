class CreateLvaModulJoinTable  < ActiveRecord::Migration
  def change 
    create_table :lvas_moduls, :id=>false do |t|
    t.integer :lva_id
    t.integer :modul_id
  end
  end
end