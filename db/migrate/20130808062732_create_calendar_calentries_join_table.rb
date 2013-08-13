class CreateCalendarCalentriesJoinTable < ActiveRecord::Migration
  def up
  create_table :calendars_calentries, :id=>false do |t|
      t.integer  :calentry_id
      t.integer  :calendar_id
    end
    add_index :calendars_calentries, [:calentry_id, :calendar_id]
    add_index :calendars_calentries, :calendar_id
  end

  def down
  end
end
