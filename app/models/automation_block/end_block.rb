class AutomationBlock::EndBlock < AutomationBlock
  validates :_next, presence: false

  def run 
    count_interactions
    automation_block_links.delete_all
  end
end