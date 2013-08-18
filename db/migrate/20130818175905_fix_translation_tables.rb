class FixTranslationTables < ActiveRecord::Migration
  def up
  Thema::Translation.reset_column_information
  if (!Thema::Translation.column_names.include?('thema_id'))
  add_column :thema_translations, :thema_id,:integer
  Thema::Translation.all.each do |t|
  t.thema_id=t.theman_id
  t.save
  end 
  end
  Studium::Translation.reset_column_information
  if (!Studium::Translation.column_names.include?('studium_id'))
  add_column :studium_translations, :studium_id,:integer
  Studium::Translation.all.each do |t|
  t.studium_id=t.studien_id
  t.save
  end
  end
  
  Themengruppe::Translation.reset_column_information
  if (!Themengruppe::Translation.column_names.include?('themengruppe_id'))
  add_column :themengruppe_translations, :themengruppe_id,:integer
  Themengruppe::Translation.all.each do |t|
  t.themengruppe_id=t.themengruppen_id
  t.save
  end
  end
  Frage::Translation.reset_column_information
  if (!Frage::Translation.column_names.include?('frage_id'))
  add_column :frage_translations, :frage_id,:integer
  Frage::Translation.all.each do |t|
  t.frage_id=t.fragen_id
  t.save
  end
  end
  
  Neuigkeit::Translation.reset_column_information
  if (!Neuigkeit::Translation.column_names.include?('neuigkeit_id'))
  add_column :neuigkeit_translations, :neuigkeit_id,:integer
  Neuigkeit::Translation.all.each do |t|
  t.neuigkeit_id=t.neuigkeiten_id
  t.save
  end
  end
  end

  def down
  remove_column :studium_translations, :studium_id
  remove_column :thema_translations, :thema_id
  remove_column :themengruppe_translations, :themengruppe_id
  remove_column :frage_translations, :frage_id
  end
end
