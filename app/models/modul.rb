class Modul < ActiveRecord::Base
  attr_accessible :desc,:name, :depend, :studium_id, :modulgruppe_ids

  has_and_belongs_to_many :lvas
  has_and_belongs_to_many :modulgruppen
  
  translates :desc,:depend, :versioning =>true, :fallbacks_for_empty_translations => true

end
