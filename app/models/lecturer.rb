# == Schema Information
#
# Table name: lecturers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  oid        :integer
#  picture    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lecturer < ActiveRecord::Base
  attr_accessible :email, :name, :oid, :picture, :remove_picture, :picture_cache, :lva_ids, :link
  has_and_belongs_to_many :lvas
  mount_uploader :picture, PictureUploader
  resourcify
end
