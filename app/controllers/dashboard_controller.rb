class DashboardController < ApplicationController
  before_action :authenticate_user!
  autocomplete :breakout, :code, extra_data: [:destination]
  autocomplete :breakout, :destination, extra_data: [:code]
  
  def index
    @route = current_user.routes.build
    @my_routes = current_user.routes.includes(:breakout)
  end

  def match_route
    @routes = Route.get_matches(search_params)
  end

  private
    def search_params
      params.require(:route).permit(:destination, :breakout, :price, :purchase_type, :quality_type)
    end
end
