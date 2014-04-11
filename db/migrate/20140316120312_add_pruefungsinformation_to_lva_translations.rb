class AddPruefungsinformationToLvaTranslations < ActiveRecord::Migration
  def change
    add_column :lva_translations, :pruefungsinformation,:text
  end
end
