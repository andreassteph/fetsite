# == Schema Information
#
# Table name: fotos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  desc       :text
#  gallery_id :integer
#  datei      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Foto < ActiveRecord::Base
  attr_accessible :datei, :desc, :gallery_id, :title
  belongs_to :gallery
  mount_uploader :datei, FotoUploader
    resourcify
    def to_jq_upload
  {
    "id" => read_attribute(:id),
    "title" => read_attribute(:title),
    "description" => read_attribute(:desc),
    "name" => read_attribute(:title),
    "size" => datei.size,
    "url" => datei.url,
    "thumbnail_url" => datei.thumb.url,
    "delete_type" => "DELETE" 
   }
  end
end
