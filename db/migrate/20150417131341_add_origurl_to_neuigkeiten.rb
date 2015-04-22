class AddOrigurlToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeiten, :origurl, :string
  end
end
