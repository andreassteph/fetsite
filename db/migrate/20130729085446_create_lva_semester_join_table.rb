class CreateLvaSemesterJoinTable < ActiveRecord::Migration
  def self.up
    create_table :lvas_semesters, :id=>false do |t|
      t.integer  :lva_id
      t.integer  :semester_id
    end
    add_index :lvas_semesters, [:lva_id, :semester_id]
    add_index :lvas_semesters, :semester_id
  end

  def self.down
    drop_table :lvas_semesters
  end
end
