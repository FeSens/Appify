require 'rails_helper'

RSpec.describe Automation, type: :model do
  describe "validations" do
    it { should belong_to(:shop).optional(false) }
    it { should have_many(:campaigns) }
    it { should have_many(:orders) }
    it { should validate_presence_of(:type) }
    it { should validate_inclusion_of(:type).in_array(Automation::TYPES) }
  end
end
