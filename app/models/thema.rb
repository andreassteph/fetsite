class Thema < ActiveRecord::Base
  attr_accessible :text, :title
  has_many :fragen
  has_many :attachments
  belongs_to :themengruppe, :foreign_key => "themengruppe_id"
  
  validates :themengruppe, :presence => true
  validates :title, :presence => true

  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
end
