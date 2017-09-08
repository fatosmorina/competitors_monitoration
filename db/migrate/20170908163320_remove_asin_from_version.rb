class RemoveAsinFromVersion < ActiveRecord::Migration[5.0]
  def change
    remove_column :versions, :asin
  end
end
