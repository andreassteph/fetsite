class Themengruppe < ActiveRecord::Base
  attr_accessible :text, :title
  has_many :themen
  has_many :fragen, through: :themen
  
  validates :title, :presence => true

  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
end
