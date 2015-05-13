# == Schema Information
#
# Table name: themengruppen
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Themengruppe < ActiveRecord::Base
  WORD_COUNT = 50
  resourcify  

  attr_accessible :text, :title, :picture, :priority, :public, :icon
  has_many :themen, class_name: 'Thema'
  has_many :fragen, through: :themen

  mount_uploader :picture, PictureUploader
  
  validates :title, :presence => true
  validates :text, :presence => true

  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
  
  scope :intern,-> {where(:public=>false)}
  scope :public,-> {where(:public=>true)}

  def self.find_wiki_default
    where(:wiki_default=>true).first
  end
  def intern
    ! self.public
end
  def make_wiki_default
    Themengruppe.where(:wiki_default=>:true).update_all(:wiki_default=>:false)
    self.wiki_default=true;
    self.save;
  end

 searchable do
    text :text
    text :title, :boost=>4.0
  end

end
