module ControllerMacros
  def login_user
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
end