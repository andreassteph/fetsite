class AddRubrikToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :rubrik_id, :integer
  end
end
