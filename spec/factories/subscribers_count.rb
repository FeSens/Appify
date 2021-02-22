FactoryBot.define do
  factory :subscriber_count do
    shop
    service { "push" }
    count { rand(1..100) }
    date { Date.today }
  end
end
