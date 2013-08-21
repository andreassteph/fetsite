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
    "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.thumb.url,
    "delete_url" => foto_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
end
