class Meeting < ActiveRecord::Base
  belongs_to :parent, :polymorphic=>true, touch: true
  belongs_to :meetingtyp

  attr_accessible :desc, :intern, :name, :parent_id, :parent_type, :calentry,:calentry_attributes, :meetingtyp_id

  belongs_to :neuigkeit, touch: true
  has_one :protocol,  :class_name=>'Document', :conditions=>{:typ=>10}, :as=>:parent
  has_one :agenda , :as=>:parent,:conditions=>{:typ=>11}, :class_name=>'Document'
  has_one :calentry, as: :object
  has_one :calendar, :through=>:meetingtyp
  has_one :rubrik, :through=>:meetingtyp
  scope :upcomming, includes(:calentry).where("calentries.start>?",1.hour.ago)
  accepts_nested_attributes_for :calentry
#  validate :agenda, :presence=>true
#  validate :protocol, :presence=>true
  validate :parent, :presence=>true
  validate :calentry, :presence=>true
  before_validation :fix_calentry
  
  def title
    self.text
  end
  def text
    unless self.meetingtyp.try(:name).to_s.empty?  
      t =  self.meetingtyp.name.to_s+", "
    else
      t=""
      t = parent.title.to_s + ", " if self.name.empty?
    end 
    t= t+ self.name.to_s
    t = t + " " + I18n.l(self.calentry.start) unless self.calentry.nil?
    t
  end
  def create_announcement(user)
    n = Neuigkeit.new
    
    n.title=self.text
    n.text ="Agenda im Anhang"
    n.rubrik = self.meetingtyp.rubrik
    n.author=user
    self.neuigkeit= n
  end
  def fix_calentry
    self.calentry.object=self unless self.calentry.nil?
    self.calentry.calendar = self.meetingtyp.rubrik.calendar 
  end
  def public? 
    ! (self.intern)
  end
  def create_protocol
   if self.protocol.nil?
     d=Document.new
     d.typ=10
     d.name="Protokoll"
     unless self.meetingtyp.protocol.nil?
       d.text=self.meetingtyp.protocol.text
     end
     d.save
     self.protocol=d
   end
  
  end
  def create_calentry
   if  self.calentry.nil?
     ce =Calentry.new
     ce.typ=2
     self.calentry=ce
   end
  end
  def create_agenda
    if self.agenda.nil?
      d=Document.new
      d.typ=11
      d.name="Agenda"
      unless self.meetingtyp.agenda.nil?
        d.text=self.meetingtyp.agenda.text
      end
      d.save
      self.agenda=d
    end
  end
  def self.new_with_date_and_typ(parent,start, typ)
    m= Meeting.new
    m.parent=parent
    m.calentry=Calentry.new
    m.calentry.typ=2
    m.calentry.start=start
    m.calentry.dauer=4
    m.meetingtyp=typ
    m
  end
  def self.new_divid_for(parent)
    "meeting_new_parent_" + parent.class.to_s + "_" + parent.id.to_s 
  end
  def divid
    "meeting_"+self.id.to_s
  end

  def update_time_from_protocol
    st= /Beginn[\s:]*([^<>]*)/.match(self.protocol.text)[1].to_s
    st= /Anfang[\s:]*([^<>]*)/.match(self.protocol.text)[1].to_s if st.empty?
    self.calentry.start=(self.calentry.start.to_date.to_s + " " +st).to_datetime unless st.empty?
    st= /Ende[\s:]*([^<>]*)/.match(self.protocol.text)[1].to_s 
   self.calentry.ende=(self.calentry.ende.to_date.to_s + " " +st).to_datetime unless st.empty?
  end
  def agenda_text
      unless self.agenda.nil?
      t=  self.agenda.text 
      else
       t= ""
      end
    t
  end
  def protocol_text
 unless self.protocol.nil?
      t=  self.protocol.text 
      else
       t= ""
      end
    t  
end

  searchable do
    text :text
    text :name, :boost=>4.0
    
    text :meetingtyp do
      meetingtyp.name
    end
    text :protocol do
   self.protocol_text
    end
  
    text :agenda do
      self.agenda_text
    end
  end
  
  
end
