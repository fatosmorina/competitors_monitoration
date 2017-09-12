require 'rails_helper'

RSpec.describe Product, type: :model do

  it { should validate_presence_of(:asin) }

  it { should validate_presence_of(:group) }

  it { should belong_to(:group) }

  it { should validate_length_of(:asin).is_equal_to(10) }

  it 'number of products in a group should not be greater than the limit set' do
    maximal_number_of_products = Product::MAX_NUMBER_OF_PRODUCTS_PER_GROUP
    user = build_user
    group = build_group(user: user, name: Faker::Name.name)
    (maximal_number_of_products+2).times { build_product(asin: Faker::Code.asin, group: group) }
    expect(group.products.count).to eq(8)
  end

  context 'it should get ASIN from amazon_url where' do
    before do
      @product = Product.new
    end

    it 'ASIN=A01LTHM8LG' do
      url = "https://smile.amazon.com/Programmable-Touchscreen-Thermostat-Geofencing-HomeKit/dp/A01LTHM8LG/ref=s9u_simh_gw_i1?_encoding=UTF8&fpl=fresh&pd_rd_i=B01LTHM8LG&pd_rd_r=21CHQY4CPXGGXZ5G3Q71&pd_rd_w=imw1F&pd_rd_wg=CNLFs&pf_rd_m=ATVPDKIKX0DER&pf_rd_s=desktop-1&pf_rd_r=XDXMZR4E839F0JD45S0F&pf_rd_r=XDXMZR4E839F0JD45S0F&pf_rd_t=36701&pf_rd_p=781f4767-b4d4-466b-8c26-2639359664eb&pf_rd_p=781f4767-b4d4-466b-8c26-2639359664eb&pf_rd_i=desktop"
      asin = "A01LTHM8LG"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = B0015T963C' do
      url = "http://www.amazon.com/Kindle-Wireless-Reading-Display-Generation/dp/B0015T963C"
      asin = "B0015T963C"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = C0015T963C' do
      url = "http://www.amazon.com/dp/C0015T963C"
      asin = "C0015T963C"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = D0015T963C' do
      url = "http://www.amazon.com/gp/product/D0015T963C"
      asin = "D0015T963C"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = E0015T963C' do
      url = "http://www.amazon.com/gp/product/glance/E0015T963C"
      asin = "E0015T963C"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = F018Y23P7K' do
      url = "https://smile.amazon.com/gp/offer-listing/F018Y23P7K/ref=dp_olp_all_mbc?ie=UTF8&condition=all"
      asin = "F018Y23P7K"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = G018Y23P7K' do
      url = "https://smile.amazon.com/product-reviews/G018Y23P7K/ref=acr_offerlistingpage_text?ie=UTF8&reviewerType=avp_only_reviews&showViewpoints=1"
      asin = "G018Y23P7K"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = H018Y23P7K' do
      url = "https://smile.amazon.com/forum/-/Tx3FTP6XCFXMJAO/ref=ask_dp_dpmw_al_hza?asin=H018Y23P7K"
      asin = "H018Y23P7K"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = I018Y23P7K' do
      url = "https://smile.amazon.com/gp/customer-reviews/R1VKN59YMEK5PC/ref=cm_cr_arp_d_viewpnt?ie=UTF8&ASIN=I018Y23P7K#R1VKN59YMEK5PC"
      asin = "I018Y23P7K"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end

    it 'ASIN = 1497445825' do
      url = "https://smile.amazon.com/Korean-Made-Simple-beginners-learning/dp/1497445825/ref=sr_1_1?ie=UTF8&qid=1493580746&sr=8-1&keywords=korean+made+simple"
      asin = "1497445825"
      calculated_asin = calculate_asin(url)
      expect(asin).to eq(calculated_asin)
    end
 
 end

  private

    def calculate_asin(url)
      @product.amazon_url = url
      @product.asin
    end

    def build_product(asin:, group:)
      Product.create(asin: asin, group: group)
    end

    def build_group(user:, name:)
      Group.create(user: user, name: Faker::Name.name)
    end

    def build_user
      FactoryGirl.create(:user)
    end

end
