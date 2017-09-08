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

  private

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
