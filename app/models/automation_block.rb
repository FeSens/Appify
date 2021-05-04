class AutomationBlock < ApplicationRecord
  class NotImplementedError < StandardError ; end

  belongs_to :_next, :class_name => 'AutomationBlock', :foreign_key => '_next_id', optional: true
  belongs_to :_prev, :class_name => 'AutomationBlock', :foreign_key => '_prev_id', optional: true
  belongs_to :campaign, optional: true
  belongs_to :shop
  belongs_to :flow_chart
  
  has_many :automation_block_links, dependent: :destroy
  has_many :pushes, through: :automation_block_links

  before_destroy :update_linked_list, :forward_pushes

  store :settings, coder: JSON

  def run
    count_interactions
    forward_pushes
  end

  def schedule
    "#{self.class.to_s.classify}EngineJob".constantize.perform_later(self)
  end

  private

  def count_interactions
    self.increment!(:count, automation_block_links.count)
  end

  def forward_pushes
    automation_block_links.update_all(automation_block_id: _next_id)
  end

  def update_linked_list
    _prev.update(_next: _next) if _prev.present?
    _next.update(_prev: _prev) if _next.present?
  end
end
