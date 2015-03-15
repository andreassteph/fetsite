class Meetingtyp < ActiveRecord::Base
  attr_accessible :agendaintern, :desc, :name, :protocolintern, :rubrik_id, :picture
  belongs_to :rubrik
  validate :rubrik, :presence=>true
  has_many :meetings
  has_one :calendar, through: :rubrik
  has_one :protocol,  :class_name=>'Document', :conditions=>{:typ=>10}, :as=>:parent
  has_one :agenda , :as=>:parent, :conditions=>{:typ=>11}, :class_name=>'Document'
  
  mount_uploader :picture, PictureUploader

  def text
    self.name
  end
end
