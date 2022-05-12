require 'elasticsearch/model'
class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_one_attached :image, dependent: :destroy
  has_one :order_item, dependent: :destroy
end
