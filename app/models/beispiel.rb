# == Schema Information
#
# Table name: beispiele
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  desc          :text
#  lva_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  beispieldatei :string(255)
#

class Beispiel < ActiveRecord::Base
  has_paper_trail
  attr_accessible :desc, :name, :lva_id, :beispieldatei, :beispieldatei_cache
  belongs_to :lva
  mount_uploader :beispieldatei, BeispieldateiUploader
  validates :beispieldatei, :presence => true
  validates :name, :presence => true
  validates :lva_id, :presence => true
  validates :lva, :presence => true
  
end
