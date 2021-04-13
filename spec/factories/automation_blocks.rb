FactoryBot.define do
  factory :automation_block do
    shop
    _next { nil }
    _prev { nil }
    campaign { nil }
    count { 1 }
    run_by { "2021-04-01 16:15:10" }
    type { "" }
  end

  factory :trigger, parent: :automation_block, class: 'AutomationBlock::Trigger' do
    type { "AutomationBlock::Trigger" }
  end

  factory :delay, parent: :automation_block, class: 'AutomationBlock::Delay' do
    type { "AutomationBlock::Delay" }
    delay { 1_000 }
  end

  factory :end_block, parent: :automation_block, class: 'AutomationBlock::EndBlock' do
    type { "AutomationBlock::EndBlock" }
  end

  factory :send_push, parent: :automation_block, class: 'AutomationBlock::SendPush' do
    type { "AutomationBlock::SendPush" }
  end
  
end
