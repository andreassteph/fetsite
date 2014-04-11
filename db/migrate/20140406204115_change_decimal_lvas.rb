class ChangeDecimalLvas < ActiveRecord::Migration
  def up
    change_column :lvas,:ects, :decimal, :precision=>5, :scale=>3
  end

  def down
  end
end
