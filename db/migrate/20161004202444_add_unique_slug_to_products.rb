class AddUniqueSlugToProducts < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :slug, unique: true
  end
end
