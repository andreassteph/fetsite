class Foto < ActiveRecord::Base
  attr_accessible :datei, :desc, :gallery_id, :title
end
