class CreateFetmeetingtops < ActiveRecord::Migration
  def change
    create_table :fetmeetingtops do |t|
      t.string :title
      t.text :text
      t.text :discussion
      t.string :ersteller
      t.integer :fetmeeting_id

      t.timestamps
    end
  end
end
