class Fetprofile < ActiveRecord::Base
  attr_accessible :active, :desc, :fetmailalias, :nachname, :picture, :short, :vorname
  has_many :memberships
  has_many :gremien, :through=> :membership
  mount_uploader :picture, PictureUploader
  def name
  [vorname, nachname, "(",short,")"].join(" ")
  end
end
