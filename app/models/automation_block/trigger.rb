 
class AutomationBlock::Trigger < AutomationBlock
  validates :_prev, presence: false

  def schedule
    #Overrides so all triggers use the same Job
    AutomationBlock::TriggerEngineJob.perform_later(self)
  end
end
