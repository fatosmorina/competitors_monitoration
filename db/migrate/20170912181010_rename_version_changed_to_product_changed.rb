class RenameVersionChangedToProductChanged < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :versions_changed, :product_changed
  end
end
