# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_resource_name, _resource)
    new_profile_path
  end
end
