require 'rails_helper'

RSpec.describe Product, type: :model do
  
  it { should validate_presence_of(:asin) }
  
  it { should validate_presence_of(:group) }

  it { should validate_length_of(:asin).is_equal_to(10) }
end
