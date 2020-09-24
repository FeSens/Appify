FactoryBot.define do
  factory :manifest do
    shop
    name { Faker::Marketing.buzzwords }
    short_name { Faker::Marketing.buzzwords }
    description { Faker::Marketing.buzzwords }
    theme_color { "#{rand(2**32).to_s(16)}" }
    background_color { "#{rand(2**32).to_s(16)}" }
  end
end