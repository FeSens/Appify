require 'rails_helper'

RSpec.describe AutomationBlock::Trigger, type: :worker, sidekiq_fake: true do  
  subject { FactoryBot.create :trigger }
  
  describe ".schedule" do 
    it "enquees TriggerEngineJob" do
      expect { subject.schedule }.to have_enqueued_job.with(subject)
    end
  end
end
