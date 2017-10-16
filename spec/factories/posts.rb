FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.word }
    ip { Faker::Number.number(10) }
  end
end
