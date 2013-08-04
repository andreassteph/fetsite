# Read about factories at https://github.com/thoughtbot/factory_girl
 

FactoryGirl.define do  
  factory :studium do
    zahl  "066506"
    name  "Automatisierung"
    desc  "TEST DESC"
    typ "Master"
    
    factory :other_studium do
		name "Telecommunication"
		desc "frueher Telekommungikation"
		zahl "066507"
		typ "Master"
	end
  end
 
end
