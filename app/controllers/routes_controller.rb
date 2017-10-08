class RoutesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_route, only: [:edit, :update, :destroy]
  before_action :verify_user, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to dashboard_path, notice: 'Route was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Route was successfully destroyed.' }
    end
  end

  private
    def set_route
      @route = Route.find(params[:id])
    end

    def verify_user
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_user == @route.user
    end

    def route_params
      params.require(:route).permit(:purchase_type, :price, :quality_type, :breakout_id)
    end
end
