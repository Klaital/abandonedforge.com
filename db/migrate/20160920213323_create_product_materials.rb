class CreateProductMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :product_materials do |t|
      t.belongs_to :product, index: true
      t.string :name
      t.string :material
      t.string :description

      t.timestamps
    end
  end
end
