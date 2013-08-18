class TranslateThemen < ActiveRecord::Migration
  def up
    Thema.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      :migrate_data => true
    })

 
		Themengruppe.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      :migrate_data => true
    })

		Frage.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      :migrate_data => true
    })

    
  end

  def down
    Thema.drop_translation_table! :migrate_data => true
		Themengruppe.drop_translation_table! :migrate_data => true
		Frage.drop_translation_table! :migrate_data => true
  end
end
