class ChangePriceTypeToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :versions, :price, :integer
  end
end
