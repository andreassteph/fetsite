# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: calentries
#
#  id         :integer          not null, primary key
#  start      :datetime
#  ende       :datetime
#  summary    :string(255)
#  typ        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Calentry < ActiveRecord::Base
  attr_accessible :ende, :start, :summary, :typ,:calendar_ids
  has_and_belongs_to_many :calendars
  validates :start, :presence => true
  validates :typ, :presence => true
  before_save :get_public
  belongs_to :object, polymorphic: true # Objekt zu dem der Calentry gehört (derzeit ein Newsartikel)
  
validate do |entry|
	if entry.ende.nil? 
		errors.add(:ende, "Es muss ein Endzeitpunkt vorhanden sein")
	end
  end  
  
  resourcify
  def get_public
  self.public = (self.try(:object).nil?)? (self.calendars.public.count>0) : object.try(:public)
  true
  end
  def start_time
    start
  end
  def start1
    start.to_date
  end
  def name
    unless self.object.nil?
      self.object.name
    else
      summary
    end
  end
  scope :public, -> { where(:public => :true) } 
  scope :upcoming, -> { where("start >= ?" , Time.now).where("start <= ?", 8.days.from_now) }
end
