class Lecturer < ActiveRecord::Base
  attr_accessible :email, :name, :oid, :picture, :lva_ids
  has_and_belongs_to_many :lvas
end
