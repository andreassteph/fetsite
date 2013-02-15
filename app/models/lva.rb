class Lva < ActiveRecord::Base
  has_paper_trail # Versionsver 
  attr_accessible :desc, :ects, :lvanr, :name, :stunden, :modul_ids
  has_and_belongs_to_many :modul
  has_and_belongs_to_many :semester
  translates :desc,  :fallbacks_for_empty_translations => true
  has_many :beispiele , :class_name => "Beispiel"
end
