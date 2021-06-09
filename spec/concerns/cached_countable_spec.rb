require "rails_helper"

class DummyClass < ActiveRecord::Base
  self.table_name = 'subscriber_counts'

  include CachedCountable
end


RSpec.describe CachedCountable, type: :job do
  let(:shop) { FactoryBot.create :shop }
  let(:redis) { Redis.current }
  let(:key) { "#{subject.class.name}/#{subject.id}/#{:count}" }
  subject { DummyClass.create(shop_id: shop.id) }

  context "when in a clear state" do
    before(:example) do 
      redis.flushall
    end

    describe "increment!" do
      it { expect { subject.increment!(:count) }.to change { subject.reload.count }.by(1) }
    end

    describe "decrement!" do
      it { expect { subject.decrement!(:count) }.to change { subject.reload.count }.by(-1) }
    end

    describe "increment" do
      it { expect { subject.increment(:count) }.to change { redis.smembers("CachedCountable") }.by([key]) }
      it { expect { subject.increment(:count) }.to change { redis.get(key).to_i }.by(1) }
      it { expect { subject.increment(:count) }.to have_enqueued_job(CachedCountableJob) }
    end

    describe "decrement" do
      it { expect { subject.decrement(:count) }.to change { redis.smembers("CachedCountable") }.by([key]) }
      it { expect { subject.decrement(:count) }.to change { redis.get(key).to_i }.by(-1) }
      it { expect { subject.increment(:count) }.to have_enqueued_job(CachedCountableJob) }
    end
  end

  context "when in a populated state" do 
    before(:context) { Redis.current.flushall }

    describe "increment" do
      it { expect { subject.increment(:count) }.to have_enqueued_job(CachedCountableJob) }
      it { expect { subject.increment(:count) }.not_to have_enqueued_job(CachedCountableJob) }
    end
  end
end
