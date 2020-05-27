class Optin < ApplicationRecord
  enum kind: %i[pwa push]
end
