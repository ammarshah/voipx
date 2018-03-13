class RoutesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_route, only: [:edit, :update, :destroy]
  before_action :verify_user, only: [:edit, :update, :destroy]

  def create
    @route = current_user.routes.new(route_params)
    @my_routes = current_user.routes.includes(:breakout).order(created_at: :desc)

    respond_to do |format|
      if @route.save
        @route = current_user.routes.build
        format.js
      else
        format.js
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
      format.html { redirect_to dashboard_path, notice: 'Route was successfully deleted.' }
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
