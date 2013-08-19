# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fetprofile do
    vorname "MyString"
    nachname "MyString"
    short "MyString"
    fetmailalias "MyString"
    desc "MyText"
    picture "MyString"
    active false
  end
end
