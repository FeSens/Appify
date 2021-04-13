require 'rails_helper'

RSpec.describe AutomationBlock::Delay, type: :worker, sidekiq_fake: true do  
  let(:delay) { 30 }
  let(:time_offset) { 7 }
  let(:shop) { FactoryBot.create :shop }
  let(:old_pushes) { FactoryBot.create_list :push, 3, shop: shop }
  let(:new_pushes) { FactoryBot.create_list :push, 3, shop: shop }
  let(:next_block) { FactoryBot.create :automation_block, shop: shop }
  subject { FactoryBot.create :delay, shop: shop, delay: delay*60, _next: next_block }
  
  describe ".schedule" do 
    it "enquees DelayEngineJob" do
      ActiveJob::Base.queue_adapter = :test
      expect { subject.schedule }.to have_enqueued_job.with(subject)
    end
  end

  context "when having older pushes" do
    before do
      travel_to (delay + time_offset).minutes.ago do
        subject.pushes << old_pushes
      end
    end

    describe ".run" do
      it { expect { subject.reload.run }.to change { subject.count }.by(old_pushes.count) }
      it { expect { subject.reload.run }.not_to have_enqueued_job(AutomationBlock::DelayEngineJob) }
    end
  end

  context "when having newer pushes" do
    before do
      travel_to (delay - time_offset).minutes.ago do
        subject.pushes << new_pushes
      end

      freeze_time
    end

    describe ".run" do
      it { expect { subject.reload.run }.to change { subject.count }.by(0) }
      it { expect { subject.reload.run }.to have_enqueued_job(AutomationBlock::DelayEngineJob).at(time_offset.minutes.from_now) }
    end
  end

  context "when having newer and older pushes" do
    before do
      travel_to (delay + time_offset).minutes.ago do
        subject.pushes << old_pushes
      end

      travel_to (delay - time_offset).minutes.ago do
        subject.pushes << new_pushes
      end

      freeze_time
    end

    describe ".run" do
      it { expect { subject.reload.run }.to change { subject.count }.by(old_pushes.count) }
    end

    describe "old pushes being forwarded and new pushes being retained" do
      before { subject.run }
      
      it { expect(subject.reload.pushes).not_to match_array(old_pushes) }
      it { expect(subject.reload.pushes).to match_array(new_pushes) }
      it { expect(next_block.reload.pushes).to match_array(old_pushes) }
      it { expect(next_block.reload.pushes).not_to match_array(new_pushes) }
      it { expect { subject.reload.run }.to have_enqueued_job(AutomationBlock::DelayEngineJob).at(time_offset.minutes.from_now) }
    end
  end


end
