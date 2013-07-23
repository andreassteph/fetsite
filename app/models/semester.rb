# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  nummer     :integer
#  studium_id :integer
#  ssws       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Semester < ActiveRecord::Base
  has_and_belongs_to_many :lvas
  attr_accessible :name, :nummer, :ss, :ws
end
