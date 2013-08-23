class AddPictureToNeuigkeiten < ActiveRecord::Migration
  def change
  add_column :neuigkeiten,:picture,:string
  end
end
