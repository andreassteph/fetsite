class AddPictureToThemengruppe < ActiveRecord::Migration
  def change
	add_column :themengruppen, :picture, :string
  end
end
