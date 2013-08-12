class AddTypToLvas < ActiveRecord::Migration
  def change
    add_column :lvas, :typ, :string
  end
end
