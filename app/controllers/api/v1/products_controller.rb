class Api::V1::ProductsController < Api::V1::BaseController
  skip_before_action :authenticate_user
  def index
    @products = Product.page(params[:page]).per(params[:per_page])
    to_json(ActiveModelSerializers::SerializableResource.new(@products, each_serializer: ProductSerializer),
    200, 'success', "Product data is fetched successfully.")
  end
end
