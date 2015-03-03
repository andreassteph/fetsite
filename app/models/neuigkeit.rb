# == Schema Information
#
# Table name: neuigkeiten
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  datum      :datetime
#  rubrik_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#

class Neuigkeit < ActiveRecord::Base
  
  attr_accessible :datum, :text, :title, :rubrik_id, :author_id,:picture, :calentries_attributes
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik, :class_name =>'Rubrik', :foreign_key => "rubrik_id"
  validates :rubrik, :presence=>true
  validates :author, :presence=>true
  translates :title,:text, :versioning=>{:gem=>:paper_trail, :options=>{:fallbacks_for_empty_translations => true}}
  has_one :calendar, through: :rubrik
  has_many :calentries, as: :object
  has_many :nlinks   
  has_one :meeting
  mount_uploader :picture, PictureUploader

  default_scope  order(:datum).reverse_order  
  scope :recent, -> { published.limit(10)}
  scope :unpublished, -> {where("datum > ? OR datum IS NULL", Date.today)}
  scope :published_scope, ->{where("datum <= ? OR datum IS NULL", Date.today)}
  scope :public, ->{includes(:rubrik).where("rubriken.public"=>true)}
  scope :intern, ->{includes(:rubrik).where("rubriken.public"=>false)}

#  scope :search, ->(query) {where("text like ? or title like ?", "%#{query}%", "%#{query}%")}
  LINKTYPES=["Thema", "Themengruppe", "Gallery", "Lva","Studium","Fetprofile", "Gremium"]
  accepts_nested_attributes_for :calentries, :allow_destroy=>true , :reject_if=> lambda{|a| a[:start].blank?}
  before_validation :sanitize


  def is_annoncement?
    self.meeting.nil?
  end
  def self.published
    where("datum <= ? AND datum IS NOT NULL", Time.now.to_date)  
  end

  def datum_nilsave
	self.datum.nil? ? Time.now + 42.years : self.datum
  end
  def public?
    self.rubrik.public
  end
  def published?
   self.datum_nilsave<Time.now.to_date
  end

  def publish
    self.datum = Date.today
  end
  def reverse_publish
    self.datum = nil
  end
  def name
    self.title
  end
  def load_from_facebook(link)
    event=FbGraph::Event.new(link).fetch(:access_token=>"CAABtfB8SO7kBADyHVHnWHqsxsU1bqqmeDdZCp7V1KF9G4o3oFHcZBq0IB8X3ird4muVIPuWKZB8jL1o9JCON60Lmnvk8rkZA2dyZAuU95dC0SWzOEnhtAEkyzZCN6hkKXdl87o38OloLBivc2kjJYmpUVKzdZAD5ywxKG7Hv5FWxXf6amWA782JSmcxgWsRDH4ZAZBXsUrhpnILNOVoKSBf1mGyfrFiPvA3QZD")
    self.title=event.name
    self.text=event.description
    unless event.start_time.nil?
      ce=Calentry.new(:start=>event.start_time, :ende=>event.end_time , :typ=>1)
      ce.ende=ce.start if ce.ende.nil?
      self.calentries<< ce
      ce.save

    end
  end
  def text_first_words
    md = /<p>(?<text>[^\<\>]*)/.match Sanitize.clean(self.text,:elements=>['p'])
    words=md[:text].split(" ") unless md.nil?
    if words.nil? || words.empty?
      "...."
    else
      words[0..100].join(" ")+ " ..." unless  words.nil?
      
    end
  end
  def has_calentries?
    !self.calentries.nil? && !self.calentries.empty?
  end
  private
  def sanitize
    self.calentries.each do |calentry|
      calentry.calendar= self.rubrik.calendar
      calentry.typ=1
      calentry.object=self
    end
  end
  searchable do
    text :text 
    text :datum
    text :title, :boost=>3.0
  end
end
