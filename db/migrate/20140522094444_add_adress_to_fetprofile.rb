class AddAdressToFetprofile < ActiveRecord::Migration
  def change
    add_column :fetprofiles, :street, :string
    add_column :fetprofiles, :plz, :string
    add_column :fetprofiles, :telnr, :string
    add_column :fetprofiles, :hdynr, :string
    add_column :fetprofiles, :skype, :string
    add_column :fetprofiles, :instant, :string
    add_column :fetprofiles, :city, :string
    add_column :fetprofiles, :birth_day, :integer
    add_column :fetprofiles, :birth_month, :integer
    add_column :fetprofiles, :birth_year, :integer
    add_column :fetprofiles, :public_birthday, :boolean
  end
end
