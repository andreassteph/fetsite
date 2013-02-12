class TranslateLvas < ActiveRecord::Migration
  def self.up
    Lva.create_translation_table!({
      :desc => :text
    }, {
      #:migrate_data => true
    })
    
    
  end

  def self.down
    Lva.drop_translation_table! #:migrate_data => true
  end
end