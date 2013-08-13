class AddPictureToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :picture, :string
  end
end
