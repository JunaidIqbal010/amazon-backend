class Api::V1::CartsController < Api::V1::BaseController
  before_action :set_cart, only: [:sync_cart]
  def sync_cart
    @cart.item_carts.destroy_all
    item_carts = item_cart_params[:item_carts].map do |item_cart|
      ItemCart.new(item_cart)
    end
    ItemCart.import item_carts, on_duplicate_key_update: [:item_cartable_id, :item_cartable_type]
    render json: { status: :success, message: "Items added successfully." }, status: :ok
  end

  private
    def set_cart
      if @current_user.present?
        @cart = Cart.find_or_create_by(user_id: @current_user&.id)
      else
        return render json: {errors: ['You should be logged in to perform this action']}, status: 401
      end
    end

    def item_cart_params
      params[:item_carts].map!{|i| i.merge!({cart_id: @cart.id})}
      params.permit(item_carts: [:item_cartable_id, :item_cartable_type, :quantity, :cart_id])
    end
end
