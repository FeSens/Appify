FactoryBot.define do
  factory :push_interaction do
    shop
    date { Date.today.at_beginning_of_month }
    count { rand(1..1_000) }
  end
end
