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
  attr_accessible :text, :title, :themengruppe_id,:isdraft, :hidelink, :hideattachment
  has_many :fragen
  has_many :attachments
  belongs_to :themengruppe, :foreign_key => "themengruppe_id"
  has_one :gremium
  has_many :nlinks, as: :link
  validates :themengruppe, :presence => true
  validates :title, :presence => true
  validates :text, :presence => true

  scope :search, ->(query) {where("text like ? or title like ?", "%#{query}%", "%#{query}%")}
  scope :outdated, -> {includes(:translations).where("thema_translations.updated_at<?",2.month.ago).where("thema_translations.locale"=>I18n.t.locale)
}
  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
  def is_outdated?
   unless translation.try(:updated_at).nil?
    translation.updated_at < 2.month.ago
   else
     true
   end
  end
  def is_wiki?
     !(wikiname.nil? || wikiname.empty?)
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
    self.text.gsub!(/src="[^"]*attachment\/datei\/(\d+)[^"]*"/){|s| full_url.path=Attachment.find($1.to_i).datei.url; 'src="'+full_url.to_s+'"'}
    self.text.gsub!(/href="[^"]*themen\/(\d+)[^"]*"/){|s| full_url.path=thema_path(Thema.find($1.to_i)); 'href="'+full_url.to_s+'"'}

  end
end
