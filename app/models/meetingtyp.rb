class Meetingtyp < ActiveRecord::Base
  attr_accessible :agendaintern, :desc, :name, :protocolintern
  belongs_to :rubrik
  validate :rubrik, :presence=>true
end
