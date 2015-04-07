# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  datei      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thema_id   :integer
#

class Attachment < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name, :datei, :datei_cache,:flag_titlepic,:parent_id, :parent_type
  belongs_to :thema
  mount_uploader :datei, AttachmentUploader
#  validates :thema, :presence => true
  validates :name, :presence => true
  scope :titlepic, ->{where(flag_titlepic: true)}
  default_scope order("LOWER(name)")
  belongs_to :parent, :polymorphic=>true
  def image?
    
 #   data_ext = datei.file.extension.downcase 
 #   %w(jpg png jpeg).include?(data_ext)
    datei.image?(datei.file)
  end
  def self.parent_attachment_list_id(parent)
    "attachments_for_"+parent.class.to_s+"_"+parent.id.to_s
  end

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
