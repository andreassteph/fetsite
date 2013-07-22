class Beispiel < ActiveRecord::Base
  has_paper_trail
  attr_accessible :desc, :name, :file, :lva_id
  has_attached_file :file
  belongs_to :lva
  translates :desc,  :fallbacks_for_empty_translations => true
end
