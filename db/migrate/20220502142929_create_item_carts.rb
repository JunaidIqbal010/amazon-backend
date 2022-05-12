class CreateItemCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :item_carts do |t|
      t.references :item_cartable, polymorphic: true, null: false
      t.integer :quantity
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
