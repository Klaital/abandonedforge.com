class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :qty
      t.integer :price
      t.string :comments

      t.timestamps
    end
  end
end
