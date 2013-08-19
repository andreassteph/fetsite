class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :fetprofile_id
      t.string :gremium_id
      t.date :start
      t.date :stop
      t.string :typ

      t.timestamps
    end
  end
end
