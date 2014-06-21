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
  attr_accessible :ende, :start, :summary, :typ,:calendar_ids, :calendar, :dauer
  belongs_to :calendar
  #belongs_to :neuigkeit
  validates :start, :presence => true
  validates :object, :presence => true
  validates :typ, :presence => true
  before_save :get_public
  belongs_to :object, polymorphic: true # Objekt zu dem der Calentry gehört (derzeit ein Newsartikel)

  scope :upcoming, ->{ where("start >= ?", Time.now).order(:start)}
  scope :recent,-> {  where("start <= ?", Time.now).order(:start).reverse_order}
  validate do |entry|
    if entry.ende.nil? 
      errors.add(:ende, "Es muss ein Endzeitpunkt vorhanden sein")
    end
  end  
  
  resourcify
  def get_public
    self.public = (self.try(:object).nil?)? (self.calendar.try(:public?)) : object.try(:public?)
    true
  end
  def s_time=(s_time)
    start 
  end
  def start_time
    start
  end
  def start1
    start.to_date
  end
  def dauer
if self.ende.nil? && self.start.nil? 
0 
else
self.ende = self.start if self.ende.nil?
    (self.ende-self.start)/3600 
end
  end
  def dauer=(dauer)
    self.ende=self.start+dauer.to_i.hours 
  end
  def name
    unless self.object.nil?
      self.object.name
    else
      summary
    end
  end
def text
   I18n.l(self.start) +" bis "+ I18n.l(self.ende) 
end
  scope :public, -> { where(:public => :true) } 
 # scope :upcoming, -> { where("start >= ?" , Time.now).where("start <= ?", 28.days.from_now) }
end
