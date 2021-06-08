require "rails_helper"

class DummyClass < ActiveRecord::Base
  self.table_name = 'subscriber_counts'

  include Countable
end


RSpec.describe Countable do
  let(:shop) { FactoryBot.create :shop }
  subject { DummyClass.create(shop_id: shop.id) }

  describe "increment" do
    it { expect { subject.increment }.to change { subject.reload.count }.by(1) }
  end

  describe "decrement" do
    it { expect { subject.decrement }.to change { subject.reload.count }.by(-1) }
  end
end
