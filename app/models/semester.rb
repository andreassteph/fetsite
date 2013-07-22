class Semester < ActiveRecord::Base
  has_and_belongs_to_many :lvas
  attr_accessible :name, :nummer, :ss, :ws
end
