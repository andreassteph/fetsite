class TranslateStudien < ActiveRecord::Migration
  def self.up
    Studium.create_translation_table!({
      :desc => :text,
      :shortdesc => :text
    }, {
      :migrate_data => true
    })

    
  end

  def self.down
    Studium.drop_translation_table! :migrate_data => true
  end
end
