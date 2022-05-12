class Order < ApplicationRecord
  has_many :order_items, dependent: :nullify
  belongs_to :user
  before_save :order_grand_total
  accepts_nested_attributes_for :order_items

  private
    def order_grand_total
      self.grand_total = self.order_items.map(&:unit_cost).sum.to_i
    end
end
