class AddLinkToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeiten, :link_typ, :string
    add_column :neuigkeiten, :link_id, :integer
  end
end
