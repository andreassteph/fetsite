class TranslateNeuigkeiten < ActiveRecord::Migration
def self.up

    Neuigkeit.create_translation_table!({
      :title => :string, 
      :text => :text
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Neuigkeit.drop_translation_table! :migrate_data => true
   

  end
end
