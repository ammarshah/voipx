class DashboardController < ApplicationController
  before_action :authenticate_user!
  autocomplete :breakout, :code, extra_data: [:destination]
  autocomplete :breakout, :destination, extra_data: [:code]
  
  def index
    @route = Route.new
    @my_routes = current_user.routes.includes(:breakout)
  end

  def match_route
    destination, breakout, price, purchase_type, quality_type = params[:destination], params[:breakout], params[:price], params[:purchase_type], params[:quality_type]

    @routes = Route.get_matches(destination, breakout, price, purchase_type, quality_type)
  end
end
