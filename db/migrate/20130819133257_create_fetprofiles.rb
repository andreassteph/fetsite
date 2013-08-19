class CreateFetprofiles < ActiveRecord::Migration
  def change
    create_table :fetprofiles do |t|
      t.string :vorname
      t.string :nachname
      t.string :short
      t.string :fetmailalias
      t.text :desc
      t.string :picture
      t.boolean :active

      t.timestamps
    end
  end
end
