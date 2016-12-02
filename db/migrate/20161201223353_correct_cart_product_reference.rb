class CorrectCartProductReference < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :cart_items_id, :integer
    add_reference :cart_items, :product, foreign_key: true
  end
end
