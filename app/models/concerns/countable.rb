module Countable
  extend ActiveSupport::Concern

  def increment(column=:count)
    self.class.increment_counter column, id
  end

  def decrement(column=:count)
    self.class.decrement_counter column, id
  end
end