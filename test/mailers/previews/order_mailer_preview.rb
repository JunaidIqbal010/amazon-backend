# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order_summary
    OrderMailer.with(order: Order.first).order_summary
  end
end
