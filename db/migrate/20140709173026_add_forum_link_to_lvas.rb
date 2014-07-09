class AddForumLinkToLvas < ActiveRecord::Migration
  def change
    add_column :lvas, :forumlink, :string
  end
end
