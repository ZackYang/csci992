class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :url
      t.float :price
      t.text :description
      t.text :image_urls
      t.boolean :has_images, default: false

      t.timestamps
    end
  end
end
