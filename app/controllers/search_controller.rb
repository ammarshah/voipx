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

  private
    def search_params
      params.require(:search).permit(:destination, :breakout, :breakout_id, :price, :purchase_type, :quality_type)
    end
end