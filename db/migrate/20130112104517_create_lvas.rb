class CreateLvas < ActiveRecord::Migration
  def up
    create_table :lvas do |t|
      t.string :name
      t.text :desc
      t.decimal :ects
      t.string :lvanr
      t.decimal :stunden
      t.timestamps
    end
  end
  def down
    drop_table :lvas
  end
end
