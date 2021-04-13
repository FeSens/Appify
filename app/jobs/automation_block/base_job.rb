class AutomationBlock::BaseJob < ApplicationJob
  queue_as :default

  def perform(block)
    block.run
  end
end
