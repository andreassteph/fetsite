class Themengruppe < ActiveRecord::Base
  has_paper_trail
  attr_accessible :text, :title
  has_many :themen
  has_many :fragen, through: :themen
  
  validates :title, :presence => true
end
