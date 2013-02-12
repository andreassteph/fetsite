class TranslateModuls < ActiveRecord::Migration
  def self.up
    Modul.create_translation_table!({
      :desc => :text,
      :depend => :text,
      :name => :string
    }, {
      #:migrate_data => true
    })
    
    
  end

  def self.down
    Modul.drop_translation_table! #:migrate_data => true
  end
end