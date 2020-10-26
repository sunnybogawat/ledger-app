FactoryBot.define do
  factory :ledger do
    name { Faker::Lorem.word }
    balance { Faker::Number.number(digits: 3)}    
  end
end
