# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: gremien
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :text
#  typ        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gremium < ActiveRecord::Base
  TYPEN={1=>"offiziell", 2=>"offiziell-temporaer", 3 => "inoffiziell",4=>"inoffiziell-tempo"}
  GESCHLECHT={0=>"saechlich", 1 => "maennlich", 2 => "weiblich"}
  ART2FALL={0=>"des", 1=>"des",2=>"der"}
  attr_accessible :desc, :name, :typ, :geschlecht,:thema_id
  has_many :memberships
  belongs_to :thema
  scope :tabs, -> { where(:typ => [1,2]) }
  
  def fall2
    Gremium::ART2FALL[self.geschlecht.to_i].to_s+" "+ self.name.to_s+ ((self.geschlecht.to_i==1||self.geschlecht.to_i==0)? "s":"") 
  end
  
end
