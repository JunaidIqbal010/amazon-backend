class OrderItemSerializer < ActiveModel::Serializer
  attributes :product

  def product
    ProductSerializer.new(object.product)
  end
end