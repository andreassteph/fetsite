class TranslateStudien < ActiveRecord::Migration
  def self.up
    Studium.create_translation_table!({
      :desc => :text,
      :shortdesc => :text
    }, {
      #:migrate_data => true
    })
    add_column :studium_translations, :studien_id, :integer
    remove_column :studium_translations, :studium_id
    
  end

  def self.down
    Studium.drop_translation_table! #:migrate_data => true
  end
end