##
# Author:: Andreas Stephanides
# License:: GPL
# Dieses Model repräsentiert eine LVA. Die notwendigen Informationen können mit TISS (dem Online System der TU Wien) synchronisiert werden

class Lva < ActiveRecord::Base
  has_paper_trail # Versionsver 
  attr_accessible :desc, :ects, :lvanr, :name, :stunden, :modul_ids
  has_and_belongs_to_many :modul
  has_and_belongs_to_many :semester
  translates :desc,  :fallbacks_for_empty_translations => true
  has_many :beispiele , :class_name => "Beispiel"
  after_initialize :load_tissdata
##
# Lade den Hash aus TISS und speichere diesen in @hash
#   
  def hash
   url= "https://tiss.tuwien.ac.at/api/course/"+ self.lvanr.to_s+"-2012W"
   @hash=Hash.from_xml(open(url).read)
  end

  def objective
    @hash["course"]["objective"][I18n.locale.to_s]
  end
  def techingContent
    @hash["course"]["teachingContent"][I18n.locale.to_s]
  end
 def person
@person
end

private
 
def load_tissdata
	url= "https://tiss.tuwien.ac.at/api/course/"+ self.lvanr.to_s+"-2012W"
   	begin 
   		@hash=Hash.from_xml(open(url).read)["tuvienna"]
  		@person=[] 
  		if @hash["course"]["lecturers"]["oid"].is_a? String
  			@person = @hash["course"]["lecturers"]["oid"]
  		else
  			@hash["course"]["lecturers"]["oid"].each do |pid|
    				@person << Hash.from_xml(open("https://tiss.tuwien.ac.at/adressbuch/adressbuch/person_via_oid/" + pid.to_s + ".xml").read)["tuvienna"]["person"]
  			end
  		end
 	rescue OpenURI::HTTPError => e
   	end 
end



end
