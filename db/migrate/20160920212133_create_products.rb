class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :thumbnail_url
      t.string :description
      t.string :slug

      t.timestamps
    end
  end
end
