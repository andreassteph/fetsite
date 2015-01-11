class Fetmeetingtop < ActiveRecord::Base
  attr_accessible :discussion, :ersteller, :fetmeeting_id, :text, :title
  belongs_to :fetmeeting
  validates :fetmeeting, presence: true 
  validates :title, presence: true , length:{minimum: 4}
  validates :ersteller, presence: true
end
