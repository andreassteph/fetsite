class AddCacheToNeuigeit < ActiveRecord::Migration
  def change
    add_column :neuigkeiten, :cache_order, :integer
    add_column :neuigkeiten, :cache_is_published, :boolean
    add_column :neuigkeiten, :cache_relevant_date, :datetime
  end
end
