class AddNeuigkeitToCalentry < ActiveRecord::Migration
  def change
add_column :calentries,:neuigkeit_id ,:integer
  end
end
