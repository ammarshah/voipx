class DashboardController < ApplicationController
  before_action :authenticate_user!
  autocomplete :breakout, :code, extra_data: [:destination]
  autocomplete :breakout, :destination, extra_data: [:code]
  
  def index
    @route = Route.new
    @my_routes = current_user.routes.includes(:breakout)
  end
end
