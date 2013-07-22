class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :name
      t.integer :nummer
      t.integer :studium_id
      t.string :ssws
      t.timestamps
    end
    add_column :lvas, :semester_id, :integer
  end
end
