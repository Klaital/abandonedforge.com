class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :thumbnail_url
      t.string :thumbnail_size
      t.string :product_image_url
      t.string :product_image_size
      t.integer :stock
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
