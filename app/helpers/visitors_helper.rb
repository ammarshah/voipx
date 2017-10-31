module VisitorsHelper
  def basic_plan_subscription(plan_id)
    if user_signed_in?
      if current_user.has_subscribed_to_basic_plan?
        "Already registered to this plan"
      end
    else
      link_to "Sign up", new_user_registration_path
    end
  end

  def pro_plan_subscription(plan_id)
    if user_signed_in?
      if current_user.has_subscribed_to_pro_plan?
        "Already registered to this plan"
      else
        link_to 'Upgrade Now', subscriptions_path(plan_id: plan_id, user_id: current_user.id), method: :post, class: "btn btn-primary"
      end
    else
      link_to "Sign up", new_user_registration_path
    end
  end
end
