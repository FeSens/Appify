 
class AutomationBlock::Trigger < AutomationBlock
  def run
    self.increment!(:count, pushes.count)
    automation_block_links.update_all(automation_block_id: _next_id)
  end

  def schedule
    TriggerEngineJob.perform_now(id: self.id)
  end
end
