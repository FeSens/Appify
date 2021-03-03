require "rails_helper"

RSpec.describe "Registration Form", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:name) { Faker::Company.name }
  let(:domain) { Faker::Internet.url(scheme: "https") }
  let(:password) { "123456" }
  let(:shop_attributes) { { domain: domain, name: name } }
  let(:user_attributes) { { email: email } }

  it "register a new shop" do
    visit new_user_registration_path

    within "#new_user" do
      fill_in "user_name", with: name
      fill_in "user_email", with: email
      fill_in "user_domain", with: domain
      fill_in "user_password", with: password
      fill_in "user_password_confirmation", with: password  
    end

    click_button "commit"
    
    expect(Shop.last).to have_attributes shop_attributes
    expect(User.last).to have_attributes user_attributes

    expect(page).to have_current_path(root_path)
    expect(page).to have_text(Shop.last.name)
  end
end
