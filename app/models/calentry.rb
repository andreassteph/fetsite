class Calentry < ActiveRecord::Base
  attr_accessible :ende, :start, :summary, :typ,:calendar_ids
  has_and_belongs_to_many :calendars
  validates :start, :presence => true
  validates :typ, :presence => true
  validate do |entry|
	if entry.ende.nil? 
		errors.add(:ende, "Es muss ein Endzeitpunkt vorhanden sein")
	end
  end
  def start_time
    start
  end
  def start1
    start.to_date
  end
  def name
	summary
  end
end
