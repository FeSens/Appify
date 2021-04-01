FactoryBot.define do
  factory :automation_block do
    _next { nil }
    _prev { nil }
    campaign { nil }
    shop { nil }
    count { 1 }
    run_by { "2021-04-01 16:15:10" }
    type { "" }
  end
end
