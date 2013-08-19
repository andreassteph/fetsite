class Foto < ActiveRecord::Base
  attr_accessible :datei, :desc, :gallery_id, :title
  belongs_to :gallery
  mount_uploader :datei, FotoUploader
  
end
