class AddNeuigkeitToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :neuigkeit_id, :integer
    add_column :meetingtyps, :rubrik_id, :integer
  end
end
