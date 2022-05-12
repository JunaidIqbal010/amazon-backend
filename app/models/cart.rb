class Cart < ApplicationRecord
  belongs_to :user
  has_many :item_carts, dependent: :destroy
end
