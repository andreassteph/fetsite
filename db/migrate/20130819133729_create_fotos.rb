class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.string :title
      t.text :desc
      t.integer :gallery_id
      t.string :datei

      t.timestamps
    end
  end
end
