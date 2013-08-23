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
  validate do |entry|
	if entry.ende.nil? 
		errors.add(:ende, "Es muss ein Endzeitpunkt vorhanden sein")
	end
  end
  belongs_to :object, polymorphic: true
  
  resourcify
  def start_time
    start
  end
  def start1
    start.to_date
  end
  def name
	summary
  end
  scope :upcoming, -> { where("start >= ?" , Time.now).where("start <= ?", 8.days.from_now) }
end
