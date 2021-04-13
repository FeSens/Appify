require 'rails_helper'

RSpec.describe AutomationBlock::EndBlock, type: :model do  
  subject { FactoryBot.create :end_block }
  let(:pushes) { FactoryBot.create_list :push, 3, shop: subject.shop }
  
  describe ".schedule" do 
    before { subject.pushes << pushes }

    it { expect { subject.schedule }.to change{subject.reload.count}.by(pushes.count) }
    it { expect { subject.schedule }.to change{AutomationBlockLink.count}.from(pushes.count).to(0) }
  
  end
end
