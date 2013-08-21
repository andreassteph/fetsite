class Lecturer < ActiveRecord::Base
  attr_accessible :email, :name, :oid, :picture, :remove_picture, :picture_cache, :lva_ids, :link
  has_and_belongs_to_many :lvas
  mount_uploader :picture, PictureUploader
  resourcify
end
