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

class Thema < ActiveRecord::Base
  attr_accessible :text, :title, :themengruppe_id
  has_many :fragen
  has_many :attachments
  belongs_to :themengruppe, :foreign_key => "themengruppe_id"
  has_one :gremium
  has_many :nlinks, as: :link
  validates :themengruppe, :presence => true
  validates :title, :presence => true
  validates :text, :presence => true
  scope :search, ->(query) {where("text like ? or title like ?", "%#{query}%", "%#{query}%")}
  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
  def is_wiki?
    wikiname.empty? || wikiname.nil?
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

end
