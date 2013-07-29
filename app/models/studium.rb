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
#

class Studium < ActiveRecord::Base
  attr_accessible :desc, :name, :typ, :zahl, :semester
  has_many :modulgruppen, inverse_of: :studium, :class_name => "Modulgruppe"
  has_many :semester, :dependent => :destroy
  
  validates :typ, :inclusion => {:in => ["Bachelor","Master"] }
  validates :name, :uniqueness => true, :presence=>true
  validates :zahl, :uniqueness => true, :presence=>true
  translates :desc,:shortdesc, :versioning =>true,:fallbacks_for_empty_translations => true
end
