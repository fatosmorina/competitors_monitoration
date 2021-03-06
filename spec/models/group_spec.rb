require 'rails_helper'

RSpec.describe Group, type: :model do

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:user) }
  
  it { should belong_to(:user) }


  it 'number of groups per user should not be greater than the limit set' do
    maximal_number_of_groups = Group::MAX_NUMBER_OF_GROUPS_PER_USER
    user = build_user
    (maximal_number_of_groups+3).times { build_group(user: user, name: Faker::Name.name) }
    expect(user.groups.count).to eq(10)
  end

  private
    def build_group(user:, name:)
      Group.create(user: user, name: name)
    end

    def build_user
      FactoryGirl.create(:user)
    end
end
