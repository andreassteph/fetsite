class CreateStudien < ActiveRecord::Migration
  def change
    create_table :studien do |t|
      t.string :zahl
      t.string :name
      t.text :shortdesc
      t.text :desc
      t.string :typ
      t.timestamps
    end

  end
end
