FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    shopify_domain { name.tr(" ", "-").delete(",").delete("'").downcase + ".myshopify.com" }
    shopify_token { Faker::Alphanumeric.alphanumeric(number: 50) }
    domain { name.tr(" ", "-").delete(",").delete("'").downcase + ".com" }
  end
end
