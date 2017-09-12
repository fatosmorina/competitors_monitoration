class ChangePriceTypeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :versions, :price, :string
  end
end
