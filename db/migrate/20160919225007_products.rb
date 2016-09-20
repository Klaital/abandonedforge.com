class Products < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.column :slug, :string
      t.column :name, :string
      t.column :created_at, :datetime
      t.column :upated_at, :datetime
      t.column :description, :text
      t.column :thumbnail_url, :string
    end
  end
end
