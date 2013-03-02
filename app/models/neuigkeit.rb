class Neuigkeit < ActiveRecord::Base
  attr_accessible :datum, :text, :title, :rubrik_id
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik, :class_name =>'Rubrik'
end
