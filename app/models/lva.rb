##
# Author:: Andreas Stephanides
# License:: GPL
# Dieses Model repräsentiert eine LVA. Die notwendigen Informationen können mit TISS (dem Online System der TU Wien) synchronisiert werden

class Lva < ActiveRecord::Base
  has_paper_trail # Versionsverfolgung
  attr_accessible :desc, :ects, :lvanr, :name, :stunden, :modul_ids
  
  has_and_belongs_to_many :modul # Gehört zu einem Modul
  has_and_belongs_to_many :semester # Gehört zu einem Semester( derzeit nicht implementiert)
  has_many :beispiele , :class_name => "Beispiel"

  translates :desc,  :fallbacks_for_empty_translations => true
  
  validates :lvanr, :presence=>true; # LVA Nr vorhanden?
  validates :ects, :presence=>true;  # ECTS vorhanden?

private

##
# Lade Daten aus TISS und füge diese in die Datenbank ein. 
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
