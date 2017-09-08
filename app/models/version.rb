class Version < ApplicationRecord
  belongs_to :product

  validates_presence_of :asin
  
end
