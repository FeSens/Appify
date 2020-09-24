FactoryBot.define do
  factory :optin do
    shop
    title { Faker::Marketing.buzzwords }
    body { Faker::Marketing.buzzwords }
    accept_button { Faker::Marketing.buzzwords }
    decline_button { Faker::Marketing.buzzwords }
    background_color { "#{rand(2**32).to_s(16)}" }
    text_color { "#{rand(2**32).to_s(16)}" }
    timer { rand(1..100) }
    kind { :push }
  end
end