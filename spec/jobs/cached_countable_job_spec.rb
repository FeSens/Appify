require 'rails_helper'

class DummyClass < ActiveRecord::Base
  self.table_name = 'subscriber_counts'

  include CachedCountable
end

RSpec.describe CachedCountableJob, type: :job do
  let(:campaign) { FactoryBot.create :campaign }
  let(:redis) { Redis.current }

  context "when incrementign by 1" do
    before do
      redis.flushall
      campaign.increment(:clicks)
    end

    describe ".perform" do
      it { expect { subject.perform }.to change { redis.get("CachedCountableQueued") }.to(nil) }
      it { expect { subject.perform }.to change { campaign.reload.clicks }.by(1) }
    end
  end

  context "when decremeting by 2" do
    before do
      redis.flushall
      campaign.decrement(:clicks, 2)
    end

    describe ".perform" do
      it { expect { subject.perform }.to change { redis.get("CachedCountableQueued") }.to(nil) }
      it { expect { subject.perform }.to change { campaign.reload.clicks }.by(-2) }
    end
  end
end
