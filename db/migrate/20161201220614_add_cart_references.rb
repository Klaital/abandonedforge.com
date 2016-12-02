class AddCartReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :cart_items, :user, foreign_key: true
    add_reference :products, :cart_items, foreign_key: true
  end
end
