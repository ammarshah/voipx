class VisitorsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_logged_in

  private
  
  def redirect_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
