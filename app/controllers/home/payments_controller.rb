# frozen_string_literal: true

module Home
  class PaymentsController < HomeController
    def index
      @profile = Profile.find(current_user.profile.id)
    end
  end
end
