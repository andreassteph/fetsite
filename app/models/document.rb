class Document < ActiveRecord::Base

  attr_accessible :etherpadkey, :name, :parent, :text, :typ, :parent_id, :parent_type

  belongs_to :parent, :polymorphic => true
  validate :name, :length=>{minimum:3}
  validate :text, :presence=>true
  validate :typ, :presence=>true
  validate :parent, :presence=>true

  def self.new_divid_for(parent)
    "document_new_parent_" + parent.class.to_s + "_" + parent.id.to_s 
  end
  def divid
    "document_"+self.id.to_s
  end
end
