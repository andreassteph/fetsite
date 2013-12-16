class AddFetprofileIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fetprofile_id, :integer
  end
end
