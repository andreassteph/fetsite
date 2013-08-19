class CreateFetzneditions < ActiveRecord::Migration
  def change
    create_table :fetzneditions do |t|
      t.string :title
      t.text :desc
      t.date :datum
      t.string :datei

      t.timestamps
    end
  end
end
