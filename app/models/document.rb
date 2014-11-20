class Document < ActiveRecord::Base
  attr_accessible :etherpadkey, :name, :parent, :text, :typ
end
