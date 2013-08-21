class Gremium < ActiveRecord::Base
  attr_accessible :desc, :name, :typ
  has_many :memberships
end
