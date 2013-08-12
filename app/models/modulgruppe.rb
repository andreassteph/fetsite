# == Schema Information
#
# Table name: modulgruppen
#
#  id         :integer          not null, primary key
#  typ        :string(255)
#  phase      :integer
#  name       :string(255)
#  desc       :text
#  studium_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Modulgruppe < ActiveRecord::Base
  attr_accessible :name, :phase, :typ,:desc, :studium_id, :modul_ids
  belongs_to :studium, :foreign_key => "studium_id"
  has_and_belongs_to_many :moduls

  resourcify

  validates :studium_id, :presence => true # Bei der Abfrage ist student_id entscheidend
  validates :studium, :presence => true # Wird gesetzt, um das richtige Feld zu melden bei Fehlern
  validates :name, :uniqueness =>{:scope => :studium_id}, :presence=>true # Pro Studium darf ein Name nur einmal vorkommen
  validates :phase,  :inclusion => {:in => [1, 2, 3, 4]}
  validates :typ, :inclusion => {:in => ["Pflicht","Vertiefungspflicht","Wahl"] }
  translates :desc, :versioning =>true,:fallbacks_for_empty_translations => true
end
