class Modulgruppe < ActiveRecord::Base
  attr_accessible :name, :phase, :typ,:desc, :studium_id
  belongs_to :studium, :foreign_key => "studium_id"
  has_and_belongs_to_many :moduls
  resourcify
  validates :studium_id, :presence => true
  validates :studium, :presence => true
  validates :name, :presence=>true,:uniqueness =>{:scope => :studium, :message => "Nur einmal je Studium erlaubt"}
  validates :phase,  :numericality => { :only_integer => true },:inclusion => {:in => [1, 2, 3, 4], :message => "%{value} is not valid, choose phase 1 to 4"}, :presence=>true
  validates :typ, :inclusion => {:in => ["Pflicht","Vertiefungspflicht","Wahl"] }
  translates :name,:desc, :versioning =>true,:fallbacks_for_empty_translations => true
end
