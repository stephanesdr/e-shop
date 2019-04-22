# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(first_name: params['first_name'], last_name: params['last_name'], phone_number: params['phone_number'], delivery_address: params['delivery_address'])
    @profile.user = current_user
    if @profile.save
      flash[:notice] = "Welcome"
      redirect_to root_path
    else
      puts @profile.errors.full_messages
      flash[:danger] = "Profile creation failed"
      redirect_to request.referer
    end
  end
end
