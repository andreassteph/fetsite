class AddTocToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :toc, :text
  end
end
