require 'rails_helper'

RSpec.describe Webhook, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:shop).optional(true) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:emitter) }
    it { is_expected.to validate_presence_of(:scope) }
    it { is_expected.to validate_length_of(:token).is_equal_to(64) }
    it { is_expected.to serialize(:scope).as(Array) }
  end
end
