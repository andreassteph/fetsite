# == Schema Information
#
# Table name: neuigkeiten
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  datum      :datetime
#  rubrik_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Neuigkeit < ActiveRecord::Base
  attr_accessible :datum, :text, :title, :rubrik_id
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik, :class_name =>'Rubrik', :foreign_key => "rubrik_id"
  validates :rubrik, :presence=>true
  validates :author, :presence=>true
end
