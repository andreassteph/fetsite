# == Schema Information
#
# Table name: calendars
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  public     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string(255)
#

class Calendar < ActiveRecord::Base
  attr_accessible :name, :public, :picture
  has_and_belongs_to_many :calentries
  mount_uploader :picture, PictureUploader
  resourcify
  scope :public, -> { where(:public => :true) }
end
