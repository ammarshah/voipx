class VisitorsController < ApplicationController
  before_action :authenticate_user!, except: [:pricing]
  before_action :redirect_if_logged_in, except: [:pricing]

  def pricing
  end

  private
  
  def redirect_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
