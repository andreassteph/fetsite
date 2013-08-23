# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thema_id   :integer
#

class Attachment < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name
  belongs_to :thema
  
  validates :thema, :presence => true
  validates :name, :presence => true
end
