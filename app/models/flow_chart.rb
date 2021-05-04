class FlowChart < ApplicationRecord
  belongs_to :shop
  has_many :automation_block, dependent: :destroy

  validates :chart_metadata, :presence => true

  private

  def create_automation_blocks
    # TODO: Create the blocks
  end

  def edit_automation_blocks
    # TODO: Modify the structure
  end
end
