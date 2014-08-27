class Fetmeeting < ActiveRecord::Base
  attr_accessible :tnlist, :typ, :calentry_attributes
  has_many :fetmeetingtops
  validates :typ, presence: true 
  validates :calentry, presence: true	
  has_one :calentry , as: :object 
  accepts_nested_attributes_for :calentry
  def public 
    true
  end		
end
