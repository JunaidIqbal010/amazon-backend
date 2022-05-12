class OrderMailer < ApplicationMailer
  default from: "amazon-clone@example.com"

  def order_summary
    @order = params[:order]
    @current_user = params[:user]
    mail(to: @current_user.email, subject: "Order Summary")
  end
end
