class Meeting < ActiveRecord::Base
  belongs_to :parent, :polymorphic=>true
  belongs_to :meetingtyp
  attr_accessible :desc, :intern, :name
  has_one :protocol,  :class_name=>'Document', :conditions=>{:typ=>10}, :as=>:parent
  has_one :agenda , :as=>:parent,:conditions=>{:typ=>11}, :class_name=>'Document'
  validate :agenda, :presence=>true
  validate :protocol, :presence=>true
  has_one :calentry, :as=>:object
  def public? 
    ! (self.intern)
  end
  def create_protocol
   if self.protocol.nil?
      d=Document.new
      d.typ=10
     d.name="Protokoll"
      d.save
      self.protocol=d
    end
  
  end
  def create_agenda
    if self.agenda.nil?
      d=Document.new
      d.typ=11
      d.name="Agenda"
      d.save
      self.agenda=d
    end
  end
end
