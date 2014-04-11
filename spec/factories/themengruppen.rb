# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :themengruppe, :class => 'Themengruppe' do
    title "MyString"
    text "MyText"
  end
end
