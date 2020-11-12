FactoryBot.define do
  factory :webhook do
    shop
    scope { ["base"] }
    token { SecureRandom.urlsafe_base64(48) }
    emitter { "Factory" }
  end
end
