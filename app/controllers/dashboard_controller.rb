class DashboardController < ApplicationController
  before_action :authenticate_user!
  autocomplete :breakout, :code
  autocomplete :breakout, :destination
  
  def index
    @route = Route.new
  end
end
