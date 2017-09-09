class DeleteBestSellerCategoryFromVersion < ActiveRecord::Migration[5.0]
  def change
    remove_column :versions, :best_seller_category
  end
end
