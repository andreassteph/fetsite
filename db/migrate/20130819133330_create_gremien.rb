class CreateGremien < ActiveRecord::Migration
  def change
    create_table :gremien do |t|
      t.string :name
      t.text :desc
      t.string :typ

      t.timestamps
    end
  end
end
