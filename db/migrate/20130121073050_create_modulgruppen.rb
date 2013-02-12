class CreateModulgruppen < ActiveRecord::Migration
  def change
    create_table :modulgruppen do |t|
      t.string :typ
      t.integer :phase
      t.string :name
      t.text :desc
      t.integer :studium_id
      t.timestamps
    end
  end
end
