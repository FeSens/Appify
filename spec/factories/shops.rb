FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    shopify_domain { name.tr(" ", "-").delete(",").delete("'").downcase + ".myshopify.com" }
    shopify_token { "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" }
    domain { name.tr(" ", "-").delete(",").delete("'").downcase + ".com" }
    theme_verified { true }
  end
end
