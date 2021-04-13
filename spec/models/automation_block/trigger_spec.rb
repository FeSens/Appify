require 'rails_helper'

RSpec.describe AutomationBlock::Trigger, type: :model do  
  subject { FactoryBot.create :trigger }
  
  describe ".schedule" do 
    it "enquees TriggerEngineJob" do
      ActiveJob::Base.queue_adapter = :test
      expect { subject.schedule }.to have_enqueued_job.with(subject)
    end
  end
end
