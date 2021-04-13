 
class AutomationBlock::Trigger < AutomationBlock
  def schedule
    AutomationBlock::TriggerEngineJob.perform_later(self)
  end
end
