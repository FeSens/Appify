class AutomationBlockLink < ApplicationRecord
  belongs_to :automation_block
  belongs_to :push
end
