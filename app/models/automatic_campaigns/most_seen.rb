module AutomaticCampaigns
  class MostSeen < ::AutomaticCampaign
    store :config, accessors: %i[color homepage], coder: JSON
  end
end
