class FixTranslationTables < ActiveRecord::Migration
  def up
  Thema::Translation.reset_column_information
  if (!Thema::Translation.column_names.include?('thema_id'))
  add_column :thema_translations, :thema_id,:integer
  Thema::Translation.update_all("thema_id=theman_id")
  end
  
  Studium::Translation.reset_column_information
  if (!Studium::Translation.column_names.include?('studium_id'))
  add_column :studium_translations, :studium_id,:integer
  Studium::Translation.update_all("studium_id=studien_id")
  end
  
  Themengruppe::Translation.reset_column_information
  if (!Themengruppe::Translation.column_names.include?('themengruppe_id'))
  add_column :themengruppe_translations, :themengruppe_id,:integer
  Themengruppe::Translation.update_all("themengruppe_id=themengruppen_id")
  end
  
  Frage::Translation.reset_column_information
  if (!Frage::Translation.column_names.include?('frage_id'))
  add_column :frage_translations, :frage_id,:integer
    Frage::Translation.reset_column_information
  Frage::Translation.all.each do |t|
  t.frage_id=t.fragen_id
  t.save
  end
  end
  
  Neuigkeit::Translation.reset_column_information
  if (!Neuigkeit::Translation.column_names.include?('neuigkeit_id'))
  add_column :neuigkeit_translations, :neuigkeit_id,:integer
 Neuigkeit::Translation.update_all("neuigkeit_id=neuigkeiten_id")
  end
  end

  def down
  remove_column :studium_translations, :studium_id
  remove_column :thema_translations, :thema_id
  remove_column :themengruppe_translations, :themengruppe_id
  remove_column :frage_translations, :frage_id
  end
end
