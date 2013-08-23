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
#  author_id  :integer
#

class Neuigkeit < ActiveRecord::Base
  
  attr_accessible :datum, :text, :title, :rubrik_id, :author_id
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik, :class_name =>'Rubrik', :foreign_key => "rubrik_id"
  validates :rubrik, :presence=>true
  validates :author, :presence=>true
  translates :title,:text, :versioning=>true, :fallbacks_for_empty_translations => true
  has_one :calentry, :as => :object
  scope :published, -> {where("datum >= ? AND datum IS NOT NULL", Time.now.to_date)}
  scope :recent, -> { published.where("updated_at >= ? ",Time.now - 7.days)}
  def datum_nilsave
	self.datum.nil? ? Time.now + 42.years : self.datum
  end
  def public
	self.rubrik.public && self.datum >=Time.now.to_date
  end
  def publish
    self.datum = Time.now
  end
  def reverse_publish
    self.datum = nil
  end
end
