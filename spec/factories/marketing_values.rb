FactoryBot.define do
  factory :marketing_value do
    cpc { Faker::Number.between(from: 0.0, to: 1.0).round(2) }
    cps { Faker::Number.between(from: 1.0, to: 5.0).round(2) }
    cpd { Faker::Number.between(from: 2.0, to: 8.0).round(2) }
    shop
  end
end
