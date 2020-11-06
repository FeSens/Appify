#This job is called by a lambda function outside the main application
class DeletePushJob < ApplicationJob
  def perform(push)
    push.destroy
  end
end