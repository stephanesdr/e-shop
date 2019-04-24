# frozen_string_literal: true

module ProfilesHelper
  def own_profile
    redirect_to root_path if Profile.find(params['id']) != current_user.profile
  end
end
