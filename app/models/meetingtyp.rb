class Meetingtyp < ActiveRecord::Base
  attr_accessible :agendaintern, :desc, :name, :protocolintern
  belongs_to :rubrik
  validate :rubrik, :presence=>true
  has_many :meetings
  has_one :calendar, through: :rubrik
end
