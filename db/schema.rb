# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130810214456) do

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
<<<<<<< HEAD
  end

  create_table "beispiel_translations", :force => true do |t|
    t.string   "locale"
    t.text     "desc"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "beispiele_id"
  end

  add_index "beispiel_translations", ["locale"], :name => "index_beispiel_translations_on_locale"
=======
    t.integer  "thema_id"
  end
>>>>>>> thomasb/master

  create_table "beispiele", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "lva_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "beispieldatei"
  end

  create_table "calendars", :force => true do |t|
    t.string   "name"
    t.boolean  "public"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "picture"
  end

  create_table "calendars_calentries", :id => false, :force => true do |t|
    t.integer "calentry_id"
    t.integer "calendar_id"
  end

  add_index "calendars_calentries", ["calendar_id"], :name => "index_calendars_calentries_on_calendar_id"
  add_index "calendars_calentries", ["calentry_id", "calendar_id"], :name => "index_calendars_calentries_on_calentry_id_and_calendar_id"

  create_table "calentries", :force => true do |t|
    t.datetime "start"
    t.datetime "ende"
    t.string   "summary"
    t.integer  "typ"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

<<<<<<< HEAD
=======
  create_table "frage_translations", :force => true do |t|
    t.string   "locale"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "fragen_id"
  end

  add_index "frage_translations", ["locale"], :name => "index_frage_translations_on_locale"

>>>>>>> thomasb/master
  create_table "fragen", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
<<<<<<< HEAD
=======
    t.integer  "thema_id"
>>>>>>> thomasb/master
  end

  create_table "lva_translations", :force => true do |t|
    t.integer  "lva_id"
    t.string   "locale"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lva_translations", ["locale"], :name => "index_lva_translations_on_locale"
  add_index "lva_translations", ["lva_id"], :name => "index_lva_translations_on_lva_id"

  create_table "lvas", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.decimal  "ects"
    t.string   "lvanr"
    t.decimal  "stunden"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "modul_id"
    t.integer  "semester_id"
  end

  create_table "lvas_moduls", :id => false, :force => true do |t|
    t.integer "lva_id"
    t.integer "modul_id"
  end

  create_table "lvas_semesters", :id => false, :force => true do |t|
    t.integer "lva_id"
    t.integer "semester_id"
  end

  add_index "lvas_semesters", ["lva_id", "semester_id"], :name => "index_lvas_semesters_on_lva_id_and_semester_id"
  add_index "lvas_semesters", ["semester_id"], :name => "index_lvas_semesters_on_semester_id"

  create_table "modul_translations", :force => true do |t|
    t.integer  "modul_id"
    t.string   "locale"
    t.text     "desc"
    t.text     "depend"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "modul_translations", ["locale"], :name => "index_modul_translations_on_locale"
  add_index "modul_translations", ["modul_id"], :name => "index_modul_translations_on_modul_id"

  create_table "modulgruppe_translations", :force => true do |t|
    t.integer  "modulgruppe_id"
    t.string   "locale"
    t.text     "desc"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "modulgruppe_translations", ["locale"], :name => "index_modulgruppe_translations_on_locale"
  add_index "modulgruppe_translations", ["modulgruppe_id"], :name => "index_modulgruppe_translations_on_modulgruppe_id"

  create_table "modulgruppen", :force => true do |t|
    t.string   "typ"
    t.integer  "phase"
    t.string   "name"
    t.text     "desc"
    t.integer  "studium_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "modulgruppen_moduls", :id => false, :force => true do |t|
    t.integer "modul_id"
    t.integer "modulgruppe_id"
  end

  create_table "moduls", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.text     "depend"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "neuigkeiten", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "datum"
    t.integer  "rubrik_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rubriken", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "prio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.integer  "nummer"
    t.integer  "studium_id"
    t.string   "ssws"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "studien", :force => true do |t|
    t.string   "zahl"
    t.string   "name"
    t.text     "shortdesc"
    t.text     "desc"
    t.string   "typ"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "studium_translations", :force => true do |t|
    t.string   "locale"
    t.text     "desc"
    t.text     "shortdesc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "studien_id"
  end

  add_index "studium_translations", ["locale"], :name => "index_studium_translations_on_locale"

<<<<<<< HEAD
  create_table "themen", :force => true do |t|
=======
  create_table "thema_translations", :force => true do |t|
    t.string   "locale"
>>>>>>> thomasb/master
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
<<<<<<< HEAD
  end

=======
    t.integer  "themen_id"
  end

  add_index "thema_translations", ["locale"], :name => "index_thema_translations_on_locale"

  create_table "themen", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "themengruppe_id"
  end

  create_table "themengruppe_translations", :force => true do |t|
    t.string   "locale"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "themengruppen_id"
  end

  add_index "themengruppe_translations", ["locale"], :name => "index_themengruppe_translations_on_locale"

>>>>>>> thomasb/master
  create_table "themengruppen", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "locale"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
