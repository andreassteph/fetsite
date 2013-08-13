class AddThemaidToThemaTranslations < ActiveRecord::Migration
  def change
    add_column :thema_translations, :theman_id, :integer
    remove_column :thema_translations, :themen_id, :integer
  end
end
