class Webhook < ApplicationRecord
  belongs_to :shop, optional: true
  serialize :scope, Array

  validates :emitter, presence: true
  validates :scope, presence: true
  validates :token, presence: true, length: { is: 64 }
end
