require 'rails_helper'

RSpec.describe Version, type: :model do

  it { should validate_presence_of(:product) }

  it { should belong_to(:product) }

end
