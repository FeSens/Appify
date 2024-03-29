FactoryBot.define do
  factory :manifest do
    shop
    name { Faker::Marketing.buzzwords }
    short_name { Faker::Marketing.buzzwords }
    description { "Powered by Aplicatify" }
    theme_color { rand(2**32).to_s(16).to_s }
    background_color { rand(2**32).to_s(16).to_s }
  end
end
