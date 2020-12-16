FactoryBot.define do
  factory :plan do
    name { Faker::Marketing.buzzwords }
    price { rand(1..100) }
    capped_amount { rand(price..price+100) }
    trial_days { rand(0..90) }
    terms { Faker::Marketing.buzzwords }
  end
end
