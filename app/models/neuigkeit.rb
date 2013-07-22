class Neuigkeit < ActiveRecord::Base
  attr_accessible :datum, :text, :title, :rubrik_id
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik, :class_name =>'Rubrik', :foreign_key => "rubrik_id"
  validates :rubrik, :presence=>true
  validates :author, :presence=>true
end
