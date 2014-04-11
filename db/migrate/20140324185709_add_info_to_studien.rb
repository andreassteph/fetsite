class AddInfoToStudien < ActiveRecord::Migration
  def change
    add_column :studium_translations, :qualifikation, :text
    add_column :studium_translations, :struktur, :text
    add_column :studium_translations, :jobmoeglichkeiten, :text
  end
end
