FactoryBot.define do
  factory :campaign do
    shop
    name { Faker::Beer.brand }
    tag { Faker::Beer.name.gsub(" ", "-") }
    segmentation_size { rand(1..1_000) }
    delivered { rand(1..segmentation_size) }
    clicks { rand(1..delivered) }
    title { Faker::Marketing.buzzwords }
    body { Faker::Marketing.buzzwords }
    url { "https://www.google.com" }
  end
end
