class CreateMeetingtyps < ActiveRecord::Migration
  def change
    create_table :meetingtyps do |t|
      t.string :name
      t.text :desc
      t.boolean :agendaintern, :default=>false
      t.boolean :protocolintern, :default=>true
      t.timestamps
    end
  end
end
