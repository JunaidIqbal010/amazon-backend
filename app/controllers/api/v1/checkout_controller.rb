class Api::V1::CheckoutController < Api::V1::BaseController
  rescue_from Stripe::CardError, with: :catch_exception
  before_action :authenticate_user

  def create
    StripeChargesServices.new(charges_params, @current_user).call
  end

  private
    def charges_params
      params.permit(:stripeToken, :orderAmount)
    end
end