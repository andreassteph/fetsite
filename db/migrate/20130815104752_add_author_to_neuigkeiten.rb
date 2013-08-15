class AddAuthorToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeiten, :author_id, :integer
  end
end
