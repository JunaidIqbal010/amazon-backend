class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :price, :rating, :image_url
  def image_url
    "http://localhost:3000" + rails_representation_url(object.image, only_path: true) if object.image.attached? 
  end
end
