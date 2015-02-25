class AddFlagsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :flag_titlepic, :boolean
  end
end
