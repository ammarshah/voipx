class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :admin_only

  layout 'admin'

  def admin_only
    unless current_user.has_role?(:admin)
      redirect_to root_path, alert: "Access denied."
    end
  end
end