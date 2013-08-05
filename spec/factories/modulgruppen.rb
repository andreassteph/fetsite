# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :modulgruppe do
  typ "Pflicht"
  phase 1
  name "Pflichtmodule 1"
  desc "ASDFASDF"
	factory :other_modulgruppe do
	name "PFlichtmodule 2"
	desc "sdafaswdfsfr"
	end
  end

end
