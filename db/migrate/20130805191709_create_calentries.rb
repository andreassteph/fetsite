class CreateCalentries < ActiveRecord::Migration
  def change
    create_table :calentries do |t|
      t.timestamp :start
      t.timestamp :ende
      t.string :summary
      t.integer :typ

      t.timestamps
    end
  end
end
