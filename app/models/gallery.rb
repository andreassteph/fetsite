class Gallery < ActiveRecord::Base
  attr_accessible :datum, :desc, :name
  has_many :fotos
end
