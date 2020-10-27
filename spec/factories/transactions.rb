FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.number(digits: 03) }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today)}
    transaction_type {['expense','revenue'].sample}
    description { Faker::Lorem.word }    
    ledger
  end
end
