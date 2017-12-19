class SearchController < ApplicationController
  def index
    @search = Search.new(search_params)
    respond_to do |format|
      if @search.valid?
        @routes = Route.get_matches(search_params, current_user)
        format.html
      else           
        format.html { render :index }
      end
    end
  end

  def add_to_my_routes
    if params[:purchase_type] == "any"
      purchase_types = Route.purchase_types.keys # i.e. ["buy", "sell"]
    else
      purchase_types = [params[:purchase_type]] # i.e. ["buy"] or ["sell"]
    end

    if params[:quality_type] == "any"
      quality_types = Route.quality_types.keys # i.e. ["cli", "non_cli"]
    else
      quality_types = [params[:quality_type]] # i.e. ["cli"] or ["non_cli"]
    end

    purchase_types.each do |pt|
      quality_types.each do |qt|
        begin
          route = Route.create!(purchase_type: pt, quality_type: qt, price: params[:price], breakout_id: params[:breakout_id], user_id: current_user.id)
        rescue Exception => e
          redirect_to dashboard_path(), alert: e.message
        end
      end
    end
    redirect_to dashboard_path()
  end

  private
    def search_params
      params.require(:search).permit(:destination, :breakout, :breakout_id, :price, :purchase_type, :quality_type)
    end

    def route_params
      params.require(:route).permit(:breakout_id, :price, :purchase_type, :quality_type)
    end
end