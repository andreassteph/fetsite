class AddCrawledAtToCrawlobjects < ActiveRecord::Migration
  def change
    add_column :crawlobjects, :crawled_at, :timestamp
  end
end
