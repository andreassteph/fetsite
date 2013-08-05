class CreateFragen < ActiveRecord::Migration
  def change
    create_table :fragen do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
