class OrderSerializer < ActiveModel::Serializer
  attributes :id, :address, :grand_total, :updated_at
  has_many :order_items, serializer: OrderItemSerializer
  def updated_at
    object.updated_at.strftime("%e %b, %Y")
  end
end