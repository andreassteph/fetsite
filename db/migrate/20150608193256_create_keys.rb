class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :uuid
      t.datetime :expire
      t.string :parent_type
      t.integer:parent_id
      t.integer :typ
      t.integer :user_id
      t.boolean :is_valid

      t.timestamps
    end
  end
end
