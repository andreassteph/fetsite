# == Schema Information
#
# Table name: fetprofiles
#
#  id           :integer          not null, primary key
#  vorname      :string(255)
#  nachname     :string(255)
#  short        :string(255)
#  fetmailalias :string(255)
#  desc         :text
#  picture      :string(255)
#  active       :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Fetprofile < ActiveRecord::Base
  attr_accessible :active, :desc, :fetmailalias, :nachname, :picture, :short, :vorname, :memberships_attributes, :remove_picture, :picture_cache
  has_many :memberships, dependent: :delete_all
  has_many :gremien, :through=> :membership
  mount_uploader :picture, PictureUploader
  has_paper_trail
validates :desc, :presence=>true
  validates :nachname, length:{minimum: 3},:presence=>true
  validates :vorname, length:{minimum: 3},:presence=>true
 

 accepts_nested_attributes_for :memberships, :reject_if=>lambda{|a| a[:typ].blank?|| a[:start].blank? ||a[:gremium_id].blank?}
 
  def name
    [vorname, nachname, ((short.empty?)? "": ["(",short,")"].join)].join(" ")
  end
  scope :active, -> { where(:active=>true).order(:vorname) } 
  def fetmail
    (fetmailalias.nil? || fetmailalias.empty?) ? short.to_s + "@fet.at" : fetmailalias.to_s + "@fet.at"
  end
end
