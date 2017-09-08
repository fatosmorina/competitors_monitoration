class Version < ApplicationRecord

  belongs_to :product
  monetize :price_cents
  validates_presence_of :product

end
