class VersionService

  def initialize(asin)
    @asin = asin
  end

  def get_version
    {
      asin:              @asin,
      title:             title,
      images:            images,
      features:          features,
      reviews_number:    reviews_number,
      best_seller_rank:  best_seller_rank,
      price:             price,
      inventory:         inventory
    }
  end

  def title
    item_attributes['Title']
  end

  def images
    image_urls = []
    image_sets.each do |i|
      if i.is_a?(Hash)
        image_urls<<i['LargeImage']['URL']
      else
        image_urls<<i[1]['URL']
      end
    end
    image_urls.uniq.join(",")
  end

  def features
    item_attributes['Feature']
  end

  def reviews_number
    retries = 3
    begin
      reviews_page = Nokogiri::HTML(open(customer_reviews_url))
      number_of_reviews = reviews_page.css('.crAvgStars a').text.to_i
    rescue OpenURI::HTTPError
      retries -= 1
      sleep 1
      retry if retries > 0
      nil
    end
    number_of_reviews
  end

  def customer_reviews_url
    item['CustomerReviews']['IFrameURL']
  end

  #When SalesRank is not given, we need to get SalesRank from the item with
  #ASIN: ParentASIN
  def best_seller_rank
    if @asin == item['ParentASIN']
      item['SalesRank']
    else
      item_lookup(asin: item['ParentASIN'], response_group: 'SalesRank')['SalesRank']
    end
  end

  def price
    if item_attributes['ListPrice']
      item_attributes['ListPrice']['FormattedPrice']
    end
  end

  def inventory
    hmac = SecureRandom.base64
    cart = nil
    Retryable.retryable(tries: 3, sleep: 1, on: Excon::Error::ServiceUnavailable) do
      cart = vacuum.cart_create(
        query: {
          'HMAC' => hmac,
          'Item.1.ASIN' => @asin,
          'Item.1.Quantity' => 999
        }
      )
    end
    if cart.nil?
      0
    else
      cart = cart.to_h
      errors = cart['CartCreateResponse']['Cart']['Request']['Errors'] 
      if errors && errors['Code'] == 'AWS.ECommerceService.ItemNotEligibleForCart'
        0
      else
        cart['CartCreateResponse']['Cart']['CartItems']['CartItem']['Quantity'].to_i
      end
    end
  end

  def item_attributes
    @item_attributes ||= item['ItemAttributes']
  end

  def image_sets
    @image_sets ||= item['ImageSets']['ImageSet']
  end

  def item
    @item ||= item_lookup(asin: @asin, response_group: 'ItemAttributes,Images,Reviews')
  end

  def item_lookup(asin:, response_group:)
    perform_item_lookup(asin: asin, response_group: response_group)['ItemLookupResponse']['Items']['Item']
  end

  def perform_item_lookup(asin:, response_group:)
    Retryable.retryable(sleep: 1, on: Excon::Error) do |retries, exception|
      raise 'Error while trying to connect' if retries == 3    
      @response = vacuum.item_lookup(
        query: {
          ItemId: asin,
          ResponseGroup: response_group
        }
      ).to_h
    end
    validate_response
  end

  def validate_response
    response_request = @response['ItemLookupResponse']['Items']['Request'] 
    if response_request['IsValid'] == 'True' || response_request['Errors'].nil?
      @response
    else
      raise 'Response was invalid.'
    end
  end

  def vacuum
    @vacuum ||= Vacuum.new('US').configure(
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      associate_tag: ENV['AWS_ASSOCIATE_TAG']
    )
  end
end



