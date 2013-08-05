class Attachment < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name
  belongs_to :thema
  
  validates :thema, :presence => true
  validates :name, :presence => true
end
