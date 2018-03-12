class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:autocomplete_breakout_code, :autocomplete_breakout_destination]
  autocomplete :breakout, :code, extra_data: [:destination]
  autocomplete :breakout, :destination, extra_data: [:code]
  
  def index
    @route = current_user.routes.build
    @my_routes = current_user.routes.includes(:breakout).order(created_at: :desc)
  end

  def match_route
    @routes = Route.get_matches(search_params, current_user).order(price: :asc)
  end

  def unread_messages_count
    @in_dashboard = request.referrer.sub(request.base_url, '').include?('dashboard') # we will use this flag to determine whether the request came from Dashboard page or not and then decide the appropriate html in the partial
    render partial: "layouts/unread_messages_count"
  end

  private
    def search_params
      params.require(:route).permit(:destination, :breakout, :price, :purchase_type, :quality_type)
    end
end
