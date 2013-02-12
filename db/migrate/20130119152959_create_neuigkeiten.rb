class CreateNeuigkeiten < ActiveRecord::Migration
  def change
    create_table :neuigkeiten do |t|
      t.string :title
      t.text :text
      t.datetime :datum
      t.integer :rubrik_id
      t.timestamps
    end
  end
end
