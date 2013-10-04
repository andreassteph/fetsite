class AddCalendarToCalentries < ActiveRecord::Migration
  def change
    add_column :calentries, :calendar_id,:integer
    add_index :calentries, :calendar_id
    
    drop_table :calendars_calentries
    
end
end
