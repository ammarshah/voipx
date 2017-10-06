class SearchController < ApplicationController
  def index
    @routes = Route.get_matches(search_params)
  end

  private
    def search_params
      if params[:search_navbar].present?
        params.require(:search_navbar).permit(:destination, :breakout, :price, :purchase_type, :quality_type)
      else
        params.require(:search).permit(:destination, :breakout, :price, :purchase_type, :quality_type)
      end
    end
end