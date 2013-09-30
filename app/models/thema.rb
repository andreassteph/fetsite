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
  validates :themengruppe, :presence => true
  validates :title, :presence => true

  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
end
