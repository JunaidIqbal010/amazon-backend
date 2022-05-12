class ItemCart < ApplicationRecord
  belongs_to :item_cartable, polymorphic: true
  belongs_to :cart

  def unit_cost
    self.quantity * self.item_cartable.price
  end
end
