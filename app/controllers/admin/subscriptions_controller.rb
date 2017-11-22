class Admin::SubscriptionsController < AdminController

  def index
    @q = Subscription.ransack(params[:q])
    @subscriptions = @q.result.includes(:plan, :user)
  end

end