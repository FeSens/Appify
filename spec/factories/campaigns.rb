FactoryBot.define do
  factory :campaign do
    shop
    name { Faker::Beer.unique.brand }
    tag { Faker::Beer.name.gsub(" ", "-") }
    segmentation_size { rand(1..1_000) }
    delivered { rand(1..segmentation_size) }
    impressions { rand(1..delivered) }
    clicks { rand(1..impressions) }
    title { Faker::Marketing.buzzwords }
    body { Faker::Marketing.buzzwords }
    url { UrlBuilder.call(shop.domain, name) }
  end
end
