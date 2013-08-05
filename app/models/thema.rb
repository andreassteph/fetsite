class Thema < ActiveRecord::Base
  has_paper_trail
  attr_accessible :text, :title
  has_many :fragen
  has_many :attachments
  belongs_to :themengruppe
  
  validates :themengruppe, :presence => true
  validates :title, :presence => true
end
