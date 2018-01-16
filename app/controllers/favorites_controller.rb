class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:route).order(created_at: :desc)
  end

  def create
    @favorite = Favorite.new(user_id: current_user.id, route_id: params[:route_id])

    respond_to do |format|
      if @favorite.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find params[:id]
    @favorite.destroy
    respond_to do |format|
      format.js
    end
  end
end
