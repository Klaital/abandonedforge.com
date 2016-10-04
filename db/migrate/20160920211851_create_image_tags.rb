class CreateImageTags < ActiveRecord::Migration[5.0]
  def change
    create_table :image_tags do |t|
      t.belongs_to :image, index: true
      t.string :tag
      t.timestamps
    end
  end
end
