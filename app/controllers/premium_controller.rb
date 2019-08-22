class PremiumController < ApplicationController
  before_action :authenticate_user!
  def new
    if user_signed_in? && current_user.subscribed?
      redirect_to root_path, notice: "You already a subscriber"
    end
  end

  def create
    Stripe.api_key = Rails.application.credentials.stripe_api_key
    plan_id = Rails.application.credentials.webbit_premium_plan_id
    plan = Stripe::Plan::retrieve(plan_id)
    token = params[:stripeToken]

    customer = if current_user.stripe_id?
                 Stripe::Customer.retrieve(current_user.stripe_id)
               else
                 Stripe::Customer.create(email: current_user.email, source: token)
               end
    subscription = customer.subscriptions.create(plan: plan_id)

    options = {
        stripe_id: customer.id,
        stripe_subscription_id: subscription.id,
        subscribed: true
    }

    options.merge!(
        card_last4: params[:user][:card_last4],
        card_exp_month: params[:user][:card_exp_month],
        card_exp_year: params[:user][:card_exp_year],
        card_type: params[:user][:card_brand]
    ) if params[:user][:card_last4]

    # byebug

    current_user.update(options)

    redirect_to root_path, notice: "You are successfully subscribed!"
  end

  def destroy
    Stripe.api_key = Rails.application.credentials.stripe_api_key
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)
    current_user.update(subscribed: false)

    redirect_to root_path, notice: "Your subscription has been cancelled"
  end

end