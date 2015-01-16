# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :text
#  datum      :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gallery < ActiveRecord::Base
  WORD_COUNT = 20
  attr_accessible :datum, :desc, :name, :foto_ids
  has_many :fotos, :dependent => :destroy # Delete fotos if gallery is destroyed
  has_many :nlinks, as: :link
#    scope :search, ->(query) {where("name like ? or galleries.desc like ?", "%#{query}%", "%#{query}%")}
  searchable do 
    text :desc
    text :name, :boost=>3.0
  end

  def title
    name
  end
end
   
