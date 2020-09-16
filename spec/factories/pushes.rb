FactoryBot.define do
  factory :push do
    shop
    endpoint { "localhost:3000/push_endpoint" }
    auth { rand(36**64).to_s(36) }
    p256dh { rand(36**64).to_s(36) }
    subscriber_id { rand(36**64).to_s(36) }
  end
end
