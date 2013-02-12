class Neuigkeit < ActiveRecord::Base
  attr_accessible :datum, :text, :title
  belongs_to :author, :class_name =>'User'
  belongs_to :rubrik
end
