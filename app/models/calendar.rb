class Calendar < ActiveRecord::Base
  attr_accessible :name, :public, :picture
  has_and_belongs_to_many :calentries
  mount_uploader :picture, PictureUploader
end
