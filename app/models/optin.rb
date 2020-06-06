class Optin < ApplicationRecord
  enum kind: { pwa: 0, push: 1 }
end
