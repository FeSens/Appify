class AutomationBlock < ApplicationRecord
  class NotImplementedError < StandardError; end

  belongs_to :_next, :class_name => 'AutomationBlock', :foreign_key => '_next_id'
  belongs_to :_prev, :class_name => 'AutomationBlock', :foreign_key => '_prev_id'
  belongs_to :campaign
  belongs_to :shop
  
  before_destroy :update_linked_list

  def run
    raise NotImplementedError
  end

  def schedule
    raise NotImplementedError
  end

  private

  def update_linked_list
    if _prev.present?
      _prev.update(_next: _next)
    
    if _next.present?
      _next.update(_prev:_prev)
  end
end
