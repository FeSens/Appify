class Optin < ApplicationRecord
  belongs_to :shop
  enum kind: { pwa: 0, push: 1, page: 2 }
end
