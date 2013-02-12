class CreateModulgruppeModulJoinTable  < ActiveRecord::Migration
  def change 
    create_table :modulgruppen_moduls, :id=>false do |t|
    t.integer :modul_id
    t.integer :modulgruppe_id
  end
  end
end