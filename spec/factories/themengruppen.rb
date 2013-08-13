# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :themagruppen, :class => 'Themengruppe' do
    title "MyString"
    text "MyText"
  end
end
