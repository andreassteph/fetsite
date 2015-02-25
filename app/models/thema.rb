
# == Schema Information
#
# Table name: themen
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  text            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  themengruppe_id :integer
#
require 'uri'
class Thema < ActiveRecord::Base
include Rails.application.routes.url_helpers
  attr_accessible :text, :title, :themengruppe_id,:isdraft, :hidelink, :hideattachment, :sticky_startpage,:sticky_intern
  has_many :fragen
  has_many :attachments
  belongs_to :themengruppe, :foreign_key => "themengruppe_id"
  has_one :gremium
  has_many :nlinks, as: :link
  validates :themengruppe, :presence => true
  validates :title, :presence => true
  validates :text, :presence => true
  has_many :titlepics, :as=>:parent, :class_name=>'Attachment', :conditions=>{:flag_titlepic=>true}
  has_many :meetings, :as=>:parent
  has_many :documents, :as=>:parent
  scope :public, where(:isdraft=>false).includes(:themengruppe).where("themengruppen.public"=>true)
  default_scope order("themen.priority").reverse_order
  # scope :search, ->(query) {where("themen.text like ? or themen.title like ?", "%#{query}%", "%#{query}%")}
  resourcify
  searchable do
    text :text
    text :title, :boost=>4.0
  end
  scope :outdated, -> {includes(:translations).where("thema_translations.updated_at<?",7.month.ago).where("thema_translations.locale"=>I18n.t.locale)
  }
  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
  def is_outdated?
    unless translation.try(:updated_at).nil?
      translation.updated_at < 7.month.ago
    else
      false
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
  
  def fix_links(host)
    full_url= URI.parse(root_url(:host=>host))
    self.text.gsub!(/src="[\.\/]*uploads\/attachment\/datei\/(\d+)\/thumb_big[^"]*"/){|s| full_url.path=Attachment.find($1.to_i).datei.thumb_big.url; 'src="'+full_url.to_s+'"'}
    self.text.gsub!(/src="[\.\/^"]*uploads\/attachment\/datei\/(\d+)\/[^"]*"/){|s| full_url.path=Attachment.find($1.to_i).datei.url; 'src="'+full_url.to_s+'"'}
    self.text.gsub!(/href="[^"]*themen\/(\d+)[^"]*"/){|s| full_url.path=thema_path(Thema.find($1.to_i)); 'href="'+full_url.to_s+'"'}
  end
end
