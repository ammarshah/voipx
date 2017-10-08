class RoutesController < ApplicationController
  before_action :authenticate_user!

  def create
    @route = current_user.routes.new(route_params)

    respond_to do |format|
      if @route.save
        format.html { redirect_to dashboard_path, notice: 'Route was successfully added.' }
      else
        @my_routes = current_user.routes.includes(:breakout) # when rendering a different conrtroller's action, we need to pass all the required variable in that view
        format.html { render 'dashboard/index' }
      end
    end
  end

  private
    def route_params
      params.require(:route).permit(:purchase_type, :price, :quality_type, :breakout_id)
    end
end
