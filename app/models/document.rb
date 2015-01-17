class Document < ActiveRecord::Base

  attr_accessible :name, :parent, :text, :typ, :parent_id, :parent_type

  belongs_to :parent, :polymorphic => true
  validate :name, :length=>{minimum:3}
  validate :text, :presence=>true
  validate :typ, :presence=>true
  validate :parent, :presence=>true
  has_paper_trail
  TYPS = { 1=>"fet_docs", 10=>"protocol", 11=> "agenda"}
  def long_name 
    if self.parent.class=="Meeting"
      "<b>"+self.parent.text+ "</b>"+ self.name
    else
      "<b>" + self.parent.title + ":</b>"+ self.name
    end
  end
  def self.new_divid_for(parent)
    "document_new_parent_" + parent.class.to_s + "_" + parent.id.to_s 
  end
  def divid
    "document_"+self.id.to_s
  end
  def self.ether
    EtherpadLite.connect('http://www.fet.at/etherpad', File.new('/srv/etherpad/etherpad-lite/APIKEY.txt'))
  end
  def ether
    if @ep.nil?
      @ep=Document.ether
    end
    @ep
  end
  def is_etherpad?
    !(etherpadkey.nil? || etherpadkey.empty?)
  end
  def move_to_etherpad
    unless self.is_etherpad?  || self.id.nil?
      self.etherpadkey="document_"+ self.id.to_s 
      self.ep_pad.html = '<div>'+self.text+'</div>'
    end      
  end
  def dump_to_etherpad
    if self.is_etherpad?
      self.ep_pad.html = '<div>'+self.text+'</div>'
    else
      self.move_to_etherpad
    end
  end
  def read_from_etherpad
    self.text=ApplicationController.helpers.strip_control_chars(self.ep_pad.html)
 
  end
  def ep_pad
    self.ep_group.pad(self.etherpadkey)
  end
  def ep_group
    t= (self.typ.nil? || self.typ ==0) ? 1 : self.typ
    Document.ether.group(Document::TYPS[t])
  end
  searchable do
    text :text
    text :name, :boost=>4.0
    if typ = 10 || typ=11
      text :meeting do
        parent.text unless parent.nil?
      end
    end
  end
   
end
