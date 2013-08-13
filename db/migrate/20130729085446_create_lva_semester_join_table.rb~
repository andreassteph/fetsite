class CreateLvaSemesterJoinTable < ActiveRecord::Migration
  def self.up
    create_table :lvas_semesters, :id=>false do |t|
      t.integer  :lva_id
      t.integer  :semester_id
    end
    add_index :lva_semesters, [:lva_id, :semester_id]
    add_index :lva_semesters, :semester_id
  end
  def change
    create_table :lvas_semesters, :id=>false do |t|
      t.integer  :lva_id
      t.integer  :semester_id
    end
    add_index :lva_semesters, [:lva_id, :semester_id]
    add_index :lva_semesters, :semester_id
  end 
  def self.down
    drop_table :lva_semesters
  end
end
