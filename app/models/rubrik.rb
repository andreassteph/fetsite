# == Schema Information
#
# Table name: rubriken
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :text
#  prio       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rubrik < ActiveRecord::Base
  attr_accessible :desc, :name, :prio, :calendar, :public, :icon, :color
  has_many :neuigkeiten, :class_name => "Neuigkeit"
  has_many :published, :class_name => "Neuigkeit", :conditions=>["Neuigkeit.published"]
  has_many :calentries, :through => :neuigkeiten, :as=>:object
  resourcify
  has_one :calendar
  validates :calendar , :presence=>true
  before_validation :sanitize
  def moderator
    u=User.with_role(:newsmoderator).first
    if !u.nil? 
      u.id
    end
  end
  def sanitize
    if self.calendar.nil?
      self.calendar=Calendar.new
   
      
end
   self.calendar.name=self.name
self.calendar.public=self.public
self.calendar.save
end
end
