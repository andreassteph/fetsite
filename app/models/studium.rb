# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: studien
#
#  id         :integer          not null, primary key
#  zahl       :string(255)
#  name       :string(255)
#  shortdesc  :text
#  desc       :text
#  typ        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
class Studium < ActiveRecord::Base
  attr_accessible :desc, :name,:abkuerzung, :typ, :zahl, :semester
  has_many :modulgruppen, inverse_of: :studium, :class_name => "Modulgruppe", :dependent => :destroy
  has_many :semester, :dependent => :destroy
  validates :abkuerzung, :length=>{:maximum=>5}, :format=>{:with=>/^[a-zA-z]{0,5}$/}
  validates :typ, :inclusion => {:in => ["Bachelor","Master"] }
  validates :name, :uniqueness => true, :presence=>true
  validates :zahl, :presence=>true, :format=>{:with=>/^0(33|66)[0-9]{3}$/}, :uniqueness => true 
  translates :desc,:shortdesc, :versioning =>true,:fallbacks_for_empty_translations => true
  def title_context
    return self.abkuerzung.to_s.strip.empty? ? self.name : self.abkuerzung
  end
  
  def batch_add_semester
    # Semester automatisch zu Studien hinzufügen
    if self.typ == "Bachelor"
      length = 6
    else
      length = 4
    end
    for i in 1..length
      semester =Semester.new()
      semester.name = i.to_s + '. ' + self.name
      semester.nummer = i
      semester.ssws = ((i % 2 == 0) ? "SS" : "WS")
      semester.save
      self.semester << semester
    end
    semester = Semester.new()
    semester.name = 'Ohne Zuordnung (' + self.name + ')'
    semester.nummer = 0
    semester.ssws = "WS"
    semester.save
    self.semester << semester
  end
end
