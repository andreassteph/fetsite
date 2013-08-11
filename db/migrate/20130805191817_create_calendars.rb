class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.boolean :public

      t.timestamps
    end
  end
end
