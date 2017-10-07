class SearchController < ApplicationController
  def index 
    @routes = Route.get_matches(search_params) if params[:search]
  end

  private
    def search_params
      params.require(:search).permit(:destination, :breakout, :price, :purchase_type, :quality_type)
    end
end