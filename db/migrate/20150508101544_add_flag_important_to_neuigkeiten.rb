class AddFlagImportantToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeiten, :flag_important, :boolean
  end
end
