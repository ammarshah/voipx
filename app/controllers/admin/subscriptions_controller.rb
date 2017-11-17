class Admin::SubscriptionsController < AdminController

  def index
    @subscriptions = Subscription.all
  end

end