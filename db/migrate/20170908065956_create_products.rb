class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :asin
      t.date :last_checked
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
