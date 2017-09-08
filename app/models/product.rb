class Product < ApplicationRecord

  belongs_to :group

  validates_presence_of :group, :asin
  validates_length_of :asin, is: 10
  
end
