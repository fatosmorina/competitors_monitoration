class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.string :title
      t.text :images
      t.text :features
      t.integer :reviews_number
      t.integer :best_seller_rank
      t.string :best_seller_category
      t.string :asin, null: false
      t.float :price
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
