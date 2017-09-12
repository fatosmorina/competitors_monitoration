class Product < ApplicationRecord

  MAX_NUMBER_OF_PRODUCTS_PER_GROUP = 8

  belongs_to :group
  has_many :versions

  validates_presence_of :group, :asin
  validates_length_of :asin, is: 10
  validate :max_number_of_products_per_group

  def amazon_url
  end

  #possible patterns: /dp/B0015T963C, /gp/product/D0015T963C, /gp/product/glance/E0015T963C, /gp/offer-listing/F018Y23P7K, /product-reviews/G018Y23P7K, &ASIN=H018Y23P7K, ?asin=H018Y23P7K
  def amazon_url=(url)
    patterns = [/\/dp\/(\w{10})(\/|\Z)/, /\/gp\/\w*?\/(\w{10})(\/|\Z)/, /\/gp\/\w*?\/\w*?\/(\w{10})(\/|\Z)/, /\/gp\/[\w-]*?\/(\w{10})(\/|\Z)/, /\/product-reviews\/(\w{10})(\/|\Z)/, /[?&]asin=(\w{10})(&|#|\Z)/i]
    patterns.each do |pattern|
      if url.match(pattern)
        self.asin = url.scan(pattern)[0].first 
        break
      end
    end
  end

private

  def max_number_of_products_per_group
    if self.group && self.group.products.count >= MAX_NUMBER_OF_PRODUCTS_PER_GROUP 
      errors.add :group, "You can only have ${MAX_NUMBER_OF_PRODUCTS_PER_GROUP} products per group at most"
    end
  end

end
