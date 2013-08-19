# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    fetprofile_id "MyString"
    gremium_id "MyString"
    start "2013-08-19"
    stop "2013-08-19"
    typ "MyString"
  end
end
