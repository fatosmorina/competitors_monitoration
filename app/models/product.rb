class Product < ApplicationRecord

  MAX_NUMBER_OF_PRODUCTS_PER_GROUP = 8

  belongs_to :group

  validates_presence_of :group, :asin
  validates_length_of :asin, is: 10
  validate :max_number_of_products_per_group


private

  def max_number_of_products_per_group
    if self.group && self.group.products.count >= MAX_NUMBER_OF_PRODUCTS_PER_GROUP 
      errors.add :group, "You can only have ${MAX_NUMBER_OF_PRODUCTS_PER_GROUP} products per group at most"

    end
  end

end
