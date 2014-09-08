class AddSexToFetprofile < ActiveRecord::Migration
  def change
    add_column :fetprofiles, :geschlecht, :integer
  end
end
