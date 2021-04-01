class AutomationBlock::EndBlock < AutomationBlock
  def run 
    automation_block_links.delete_all
  end
end