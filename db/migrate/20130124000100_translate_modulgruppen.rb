class TranslateModulgruppen < ActiveRecord::Migration
  def self.up
    Modulgruppe.create_translation_table!({
      :desc => :text#,
     # :name => :string
    }, {
      :migrate_data => true
    })
      
  end

  def self.down
    Modulgruppe.drop_translation_table! :migrate_data => true
  end
end
