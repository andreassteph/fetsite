class AddPictureToMeetingtyps < ActiveRecord::Migration
  def change
    add_column :meetingtyps, :picture, :string
  end
end
