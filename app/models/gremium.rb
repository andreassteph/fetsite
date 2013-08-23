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
  attr_accessible :desc, :name, :typ
  has_many :memberships
end
