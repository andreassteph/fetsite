class CreateFetmeetings < ActiveRecord::Migration
  def change
    create_table :fetmeetings do |t|
      t.text :tnlist
      t.integer :typ

      t.timestamps
    end
  end
end
