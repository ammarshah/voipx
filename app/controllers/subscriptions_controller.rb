class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.create(subscription_params)
    redirect_to checkout_url
  end

  def make_recurring
    if PaypalSubscription::RecurrenceCreator.create!(
        subscription: subscription,
        paypal_options: paypal_options.merge({
          payer_id: params[:PayerID],
          token: params[:token]
        })
      )
      redirect_to pricing_path(),
        notice: I18n.t('flashes.subscription.successfully_created')
    end
  end

  def destroy
    PaypalSubscription::ResourceFacade.cancel(paypal_options)

    redirect_to pricing_path(),
      notice: I18n.t('flashes.subscription.cancellation_asked')
  end

  private

  def checkout_url
    PaypalSubscription::ResourceFacade.checkout_url(
      paypal_options.merge({
        return_url: make_recurring_subscription_url(subscription),
        cancel_url: pricing_url(aborting_operation: true)
      })
    )
  end

  def paypal_options
    @paypal_options ||=
      PaypalSubscription::DefaultOptions.for(subscription)
  end

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end
  helper_method :subscription

  def subscription_params
    params.permit(:plan_id, :user_id)
  end
end
