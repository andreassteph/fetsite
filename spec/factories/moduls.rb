# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :modul do
    name ""
    factory :other_modul do
      name "Modul 1"
      end
  end
end
