FactoryBot.define do
  factory :journey do
    shop
    name { Faker::Beer.brand }
 end
end
