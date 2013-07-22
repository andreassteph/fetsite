class Studium < ActiveRecord::Base
  attr_accessible :desc, :name, :typ, :zahl
  has_many :modulgruppen, inverse_of: :studium, :class_name => "Modulgruppe"
  
  validates :typ, :inclusion => {:in => ["Bachelor","Master"] }
  validates :name, :uniqueness => true, :presence=>true
  validates :zahl, :uniqueness => true, :presence=>true
  translates :desc,:shortdesc, :versioning =>true,:fallbacks_for_empty_translations => true
end
