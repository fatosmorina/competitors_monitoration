class ChangePriceTypeAtVersion < ActiveRecord::Migration[5.0]
  def change
    change_column :versions, :price, :float
  end
end
