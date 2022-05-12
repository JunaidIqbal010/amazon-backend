class Api::V1::OrdersController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :set_cart
  def create_order
    @order = @current_user.orders.create!(order_params)
    OrderMailJob.perform_async(@order.id, @current_user.id)
    to_json(ActiveModelSerializers::SerializableResource.new(@order, serializer: OrderSerializer),
    200, 'success', "Your order is placed successfully.")
  end

  def index 
    @orders = @current_user.orders.page(params[:page]).per(params[:per_page])
    to_json(ActiveModelSerializers::SerializableResource.new(@orders, each_serializer: OrderSerializer),
    200, 'success', "Orders data is fetched successfully.")
  end

  private
    def set_cart
      @cart = @current_user.cart
    end

    def order_params
      order = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
      order[:address] = params[:address]
      @cart.item_carts.each_with_index do |item_cart, index|
        order[:order_items_attributes][index][:product_id] = item_cart.item_cartable_id
        order[:order_items_attributes][index][:unit_cost] = item_cart.unit_cost
      end
      ActionController::Parameters.new(order).permit!
    end
end