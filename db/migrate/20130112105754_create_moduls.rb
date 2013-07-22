class CreateModuls < ActiveRecord::Migration
  def change
    create_table :moduls do |t|
      t.string :name
      t.text :desc
      t.text :depend
      t.timestamps
    end
    add_column :lvas, :modul_id, :integer 
  end
end
