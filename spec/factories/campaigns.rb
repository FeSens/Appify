FactoryBot.define do
  factory :campaign do
    shop
    name { Faker::Beer.unique.brand }
    tag { Faker::Beer.name.tr(" ", "-") }
    segmentation_size { rand(1..1_000) }
    delivered { rand(1..segmentation_size) }
    impressions { rand(1..delivered) }
    clicks { rand(1..impressions) }
    title { Faker::Marketing.buzzwords }
    body { Faker::Marketing.buzzwords }
    url { UrlBuilder.call(shop.domain, name) }
    release_date { Time.at(rand(Time.now.to_f..15.days.from_now.to_f)) }
  end
end
