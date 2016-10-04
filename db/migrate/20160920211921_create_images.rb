class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.belongs_to :product, index: true
      t.string :title
      t.string :fullsize_url
      t.string :small_url

      t.timestamps
    end
  end
end
