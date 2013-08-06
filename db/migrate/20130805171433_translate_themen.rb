class TranslateThemen < ActiveRecord::Migration
  def up
    Thema.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      #:migrate_data => true
    })
		add_column :thema_translations, :themen_id, :integer
    remove_column :thema_translations, :thema_id    
 
		Themengruppe.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      #:migrate_data => true
    })
		add_column :themengruppe_translations, :themengruppen_id, :integer
    remove_column :themengruppe_translations, :themengruppe_id


		Frage.create_translation_table!({
      :title => :string,
			:text  => :text
    }, {
      #:migrate_data => true
    })
		add_column :frage_translations, :fragen_id, :integer
    remove_column :frage_translations, :frage_id    
    
  end

  def down
    Thema.drop_translation_table! #:migrate_data => true
		Themengruppe.drop_translation_table! #:migrate_data => true
		Frage.drop_translation_table! #:migrate_data => true
  end
end
