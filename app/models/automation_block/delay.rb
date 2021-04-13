class AutomationBlock::Delay < AutomationBlock
  store :settings, accessors: [:delay], coder: JSON
  validates :delay, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def run
    super

    schedule if automation_block_links.reload.present?
  end

  def schedule
    AutomationBlock::DelayEngineJob.set(wait_until: next_run_date).perform_later(self)
  end


  def count_interactions
    self.increment!(:count, delayed_push_links.count)
  end

  def forward_pushes
    delayed_push_links.update_all(automation_block_id: _next_id)
  end

  def next_run_date
    if automation_block_links.reload.present?
      return automation_block_links.reload.minimum(:updated_at) + self.delay.seconds
    end

    self.delay.seconds.from_now
  end

  def delayed_push_links
    @delayed_push_links ||= begin
      automation_block_links.where("updated_at <= ?", self.delay.seconds.ago)
    end
  end
end