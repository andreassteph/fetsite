class AddPruefungsinfosToLvas < ActiveRecord::Migration
  def change
    add_column :lvas, :pruefungsinformation, :text
    add_column :lvas, :lernaufwand, :text
  end
end
