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
  attr_accessible :active, :desc, :fetmailalias, :nachname, :picture, :short, :vorname, :memberships_attributes, :remove_picture, :picture_cache, :plz, :street, :city, :instant,:skype, :telnr, :hdynr, :birth_day, :birth_month, :birth_year,:geschlecht
  has_many :memberships, dependent: :delete_all
  has_many :gremien, :through=> :membership
  mount_uploader :picture, PictureUploader
  has_paper_trail
  validates :desc, :presence=>true
  validates :nachname, length:{minimum: 3},:presence=>true
  validates :vorname, length:{minimum: 3},:presence=>true
  validate :validate_birthday
  GESCHLECHT={0=>"gendered", 1=>"maennlich", 2=>"weiblich"}
  has_many :users
  scope :search, ->(query) {where("nachname like ? or vorname like ? or short like ?", "%#{query}%", "%#{query}%", "%#{query}%")}

 accepts_nested_attributes_for :memberships, :reject_if=>lambda{|a| a[:typ].blank?|| a[:start].blank? ||a[:gremium_id].blank?}, :allow_destroy=>true
  has_many :nlinks, as: :link
  def validate_birthday
    unless Date.valid_date?(birth_year, birth_month, birth_day)
      errors.add(:birth_month, "Invalides Datum")
      errors.add(:birth_day, "Invalides Datum")
    end
  end

  def title
    self.name
  end
  def name
    [vorname, nachname, ((short.empty?)? "": ["(",short,")"].join)].join(" ")
  end
  scope :active, -> { where(:active=>true).order(:vorname) } 
  def fetmail
    (fetmailalias.nil? || fetmailalias.empty?) ? short.to_s + "@fet.at" : fetmailalias.to_s + "@fet.at"
  end
  def adress
    connector= (self.street.nil?||self.street.empty?||(self.city.empty? && self.plz.empty?)) ? '' : ', '
    self.plz.to_s + ' ' + self.city.to_s + connector.to_s + self.street.to_s
  end
  def birthday
    if self.birth_year.nil? || self.birth_year.zero?
      Date.new( Date.today.year,self.birth_month,self.birth_day)
    else
      Date.new( self.birth_year,self.birth_month,self.birth_day)
    end
  end
end
