# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calentry do
    start "2013-08-05 21:17:10"
    ende "2013-08-05 21:17:10"
    summary "MyString"
    typ 1
  end
end
