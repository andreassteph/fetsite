class CreateRubriken < ActiveRecord::Migration
  def change
    create_table :rubriken do |t|
      t.string :name
      t.text  :desc
      t.integer :prio

      t.timestamps
    end
  end
end
