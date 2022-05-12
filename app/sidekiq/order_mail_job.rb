class OrderMailJob
  include Sidekiq::Job

  def perform(order_id, user_id)
    order = Order.find(order_id)
    user = User.find(user_id)
    OrderMailer.with(order: order, user: user).order_summary.deliver_now
  end
end
