class AddSlugToProducts < ActiveRecord::Migration[5.0]
  def change
    change_table :products do |t|
      t.string :slug
      t.index :slug
    end
  end
end
