# frozen_string_literal: true

module AdministrationHelper
  def check_if_admin
    redirect_to root_path unless current_user.admin
    flash[:alert] = "Seuls les admins ont accès à cette partie du site."
  end
end
