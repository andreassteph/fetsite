class AddLinkToLecturers < ActiveRecord::Migration
  def change
    add_column :lecturers, :link, :string
  end
end
