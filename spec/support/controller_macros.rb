# frozen_string_literal: true

module ControllerMacros
  def login_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      # user.confirm! dont need this until user has to validates his account
      sign_in user
    end
  end

  def login_admin
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.admin = true
      user.save
      # user.confirm! dont need this until user has to validates his account
      sign_in user
    end
  end
end
