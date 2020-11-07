class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def flipper_id
    "#{self.class.name}:#{id || 0}"
  end
end
