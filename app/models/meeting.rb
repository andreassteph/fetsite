class Meeting < ActiveRecord::Base
  belongs_to :parent, :polymorphic=>true
  belongs_to :meetingtyp
  attr_accessible :desc, :intern, :name, :parent_id, :parent_type, :calentry,:calentry_attributes


  has_one :protocol,  :class_name=>'Document', :conditions=>{:typ=>10}, :as=>:parent
  has_one :agenda , :as=>:parent,:conditions=>{:typ=>11}, :class_name=>'Document'
  has_one :calentry, as: :object
  accepts_nested_attributes_for :calentry
#  validate :agenda, :presence=>true
#  validate :protocol, :presence=>true
  validate :parent, :presence=>true
  validate :calentry, :presence=>true
before_validation :fix_calentry
  def fix_calentry
    self.calentry.object=self unless self.calentry.nil?
  end
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
  def self.new_divid_for(parent)
    "meeting_new_parent_" + parent.class.to_s + "_" + parent.id.to_s 
  end
  def divid
    "meeting_"+self.id.to_s
  end


end
