FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    shopify_domain { name.gsub(" ", "-").gsub(",", "").gsub("'", "").downcase + ".myshopify.com" }
    shopify_token { Faker::Alphanumeric.alphanumeric(number: 50) }
    domain { name.gsub(" ", "-").gsub(",", "").gsub("'", "").downcase + ".com" }
  end
end
