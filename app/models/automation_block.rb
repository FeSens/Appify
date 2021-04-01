class AutomationBlock < ApplicationRecord
  class NotImplementedError < StandardError ; end

  belongs_to :_next, :class_name => 'AutomationBlock', :foreign_key => '_next_id'
  belongs_to :_prev, :class_name => 'AutomationBlock', :foreign_key => '_prev_id'
  belongs_to :campaign
  belongs_to :shop
  
  has_many :automation_block_links
  has_many :pushes, through: :automation_block_links

  before_destroy :update_linked_list

  def run
    raise NotImplementedError
  end

  def schedule
    raise NotImplementedError
  end

  private

  def update_linked_list
    _prev.update(_next: _next) if _prev.present?
    _next.update(_prev: _prev) if _next.present?
  end
end
