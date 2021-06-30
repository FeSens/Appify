FactoryBot.define do
  factory :journey do
    shop
    name { Faker::Beer.unique.brand }
  end
end
