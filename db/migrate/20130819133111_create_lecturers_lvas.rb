class CreateLecturersLvas < ActiveRecord::Migration
  def change
    create_table :lecturers_lvas, :id=> false do |t|
      t.integer :lecturer_id
      t.integer :lva_id
    end





  end
end
