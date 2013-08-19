class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :desc
      t.date :datum

      t.timestamps
    end
  end
end
