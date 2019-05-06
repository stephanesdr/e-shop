# frozen_string_literal: true

class HomeController < ApplicationController
  after_action :track_action
  layout "home"

  protected

  def track_action
    ahoy.track "Home action", request.path_parameters
  end
end
