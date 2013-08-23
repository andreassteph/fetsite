# == Schema Information
#
# Table name: fetprofiles
#
#  id           :integer          not null, primary key
#  vorname      :string(255)
#  nachname     :string(255)
#  short        :string(255)
#  fetmailalias :string(255)
#  desc         :text
#  picture      :string(255)
#  active       :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Fetprofile < ActiveRecord::Base
  attr_accessible :active, :desc, :fetmailalias, :nachname, :picture, :short, :vorname
  has_many :memberships
  has_many :gremien, :through=> :membership
  mount_uploader :picture, PictureUploader
  def name
  [vorname, nachname, "(",short,")"].join(" ")
  end
  scope :active, -> { where(:active=>:true).order(:vorname) } 
end
