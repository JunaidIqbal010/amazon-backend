class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :title
      t.integer :price
      t.integer :rating

      t.timestamps
    end
  end
end
