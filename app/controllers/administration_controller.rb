# frozen_string_literal: true

class AdministrationController < ApplicationController
  include AdministrationHelper
  before_action :authenticate_user!
  before_action :check_if_admin
  layout "administration"
end
