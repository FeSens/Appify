 
class AutomationBlock::Trigger < AutomationBlock
  validates :_prev, presence: false

  def schedule
    AutomationBlock::TriggerEngineJob.perform_later(self)
  end
end
