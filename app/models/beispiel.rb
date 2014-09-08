# == Schema Information
#
# Table name: beispiele
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  desc          :text
#  lva_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  beispieldatei :string(255)
#

class Beispiel < ActiveRecord::Base
  has_paper_trail
  attr_accessible :desc, :name, :lva_id, :beispieldatei, :beispieldatei_cache, :datum
  acts_as_votable
  belongs_to :lva

  mount_uploader :beispieldatei, AttachmentUploader
  validates :beispieldatei, :presence => true
  validates :name, :presence => true
  validates :lva_id, :presence => true
  validates :lva, :presence => true
  validates :datum, :presence => true
   def to_jq_upload
  {
    "id" => read_attribute(:id),
    "title" => read_attribute(:title),
    "description" => read_attribute(:desc),
    "name" => read_attribute(:title),
    "size" => beispieldatei.size,
    "url" => beispieldatei.url,
    "thumbnail_url" => beispieldatei.thumb.url,
    "delete_type" => "DELETE" 
   }
end
end
