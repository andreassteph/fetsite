class Document < ActiveRecord::Base
  attr_accessible :etherpadkey, :name, :parent, :text, :typ
  belongs_to :parent, :polymorphic => true
  validate :name, :length=>{minimum:3}
  validate :text, :presence=>true
  validate :typ, :presence=>true
  validate :parent, :presence=>true
  
end
