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
  attr_accessible :desc, :name, :prio
  has_many :neuigkeiten, :class_name => "Neuigkeit"
  resourcify
def moderator
   u=User.with_role(:newsmoderator).first
   if !u.nil? 
     u.id
   end
end


end
