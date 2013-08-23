class RemoveNameFromSemesters < ActiveRecord::Migration
  def change
    remove_column :semesters, :name


    end
end
