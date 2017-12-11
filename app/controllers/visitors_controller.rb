class VisitorsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:pricing]

  def pricing
    @plans = Plan.all
    if params[:aborting_operation]
      Subscription.where(paypal_payer_id: nil, user_id: current_user.id).destroy_all
    end
  end

  private
  
  def redirect_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
