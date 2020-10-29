FactoryBot.define do
  factory :automatic_campaign do
    shop
    type { "AutomaticCampaigns::MostSeen" }
  end
end
