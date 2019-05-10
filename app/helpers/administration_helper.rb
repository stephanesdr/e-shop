# frozen_string_literal: true

module AdministrationHelper
  def check_if_admin
    return unless current_user.admin?

    redirect_to root_path
    flash[:alert] = "Seuls les admins ont accès à cette partie du site."
  end
end
