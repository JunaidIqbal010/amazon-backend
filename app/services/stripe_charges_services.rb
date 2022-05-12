class StripeChargesServices
  DEFAULT_CURRENCY = 'PKR'.freeze
  
  def initialize(params, user)
    @stripe_name = user.username
    @stripe_email = user.email
    @stripe_token = params[:stripeToken]
    @order_amount = params[:orderAmount]
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order_amount, :stripe_name

  def find_customer
  if user.stripe_token
    retrieve_customer(user.stripe_token)
  else
    create_customer
  end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token) 
  end

  def create_customer
    customer = Stripe::Customer.create(
      name: stripe_name,
      email: stripe_email,
      source: stripe_token
    )
    user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      amount: order_amount * 100,
      description: customer.email,
      currency: DEFAULT_CURRENCY
    )
  end
end