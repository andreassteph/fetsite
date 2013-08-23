# == Schema Information
#
# Table name: fragen
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thema_id   :integer
#

class Frage < ActiveRecord::Base
  attr_accessible :text, :title, :thema_id
  belongs_to :thema
  
  validates :thema, :presence => true
  validates :title, :presence => true
  
  translates :title,:text, :versioning =>true, :fallbacks_for_empty_translations => true
end
