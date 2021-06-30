FactoryBot.define do
  factory :interaction do
    journey
    name  { Faker::Marketing.buzzwords }
  end
end
