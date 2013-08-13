class CreateThemen < ActiveRecord::Migration
  def change
    create_table :themen do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
