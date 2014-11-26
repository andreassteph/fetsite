class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.text :desc
      t.boolean :intern, :default=>true
      t.references :parent, :polymorphic=>{:default=>'Thema'}      
      t.references :meetingtyp
      t.timestamps
    end
    add_index :meetings, :parent_id
    add_index :meetings, :parent_type
    add_index :meetings, :meetingtyp_id
  end
end
