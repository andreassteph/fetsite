class CreateNlinks < ActiveRecord::Migration
  def change
    create_table :nlinks do |t|
      t.string :title
      t.integer :sort
      t.integer :neuigkeit_id
      t.integer :link_id
      t.string :link_type

      t.timestamps
    end
  end
end
