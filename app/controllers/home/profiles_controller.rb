# frozen_string_literal: true

module Home
  class ProfilesController < HomeController
    include ProfilesHelper
    before_action :authenticate_user!
    before_action :own_profile

    def new
      @profile = Profile.new
    end

    def show
      @profile = Profile.find(params[:id])
    end

    def create
      @profile = Profile.new(first_name: params['first_name'], last_name: params['last_name'], phone_number: params['phone_number'], street: params['street'], postal_code: params['postal_code'], city: params['city'])
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

    def edit
      @profile = Profile.find(params[:id])
    end

    def update
      @profile = Profile.find(current_user.profile.id)
      @profile.update(first_name: params['profile']['first_name'], last_name: params['profile']['last_name'], phone_number: params['profile']['phone_number'], street: params['profile']['street'], postal_code: params['profile']['postal_code'], city: params['profile']['city'])
      if @profile.errors.any?
        flash[:danger] = "Profile edition failed"
      else
        flash[:notice] = "Profile edition succeed"
      end
      redirect_to request.referer
    end
  end
end
