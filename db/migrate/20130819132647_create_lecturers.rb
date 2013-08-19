class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name
      t.string :email
      t.integer :oid
      t.string :picture

      t.timestamps
    end
  end
end
