class AddParentToAttachment < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.references :parent, :polymorphic=>{:default=>'Thema'}
    end
  end
end
