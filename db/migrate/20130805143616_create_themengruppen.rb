class CreateThemengruppen < ActiveRecord::Migration
  def change
    create_table :themengruppen do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
