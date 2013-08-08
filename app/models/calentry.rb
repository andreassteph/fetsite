class Calentry < ActiveRecord::Base
  attr_accessible :ende, :start, :summary, :typ,:calendar_ids
  has_and_belongs_to_many :calendar
  def start_time
    start
  end
  def name
	summary
  end
end
