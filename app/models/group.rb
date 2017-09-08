class Group < ApplicationRecord

  MAX_NUMBER_OF_GROUPS_PER_USER = 10

  belongs_to :user
  has_many :products, dependent: :destroy

  validates_presence_of :user, :name

  validate :max_number_of_groups_per_user, on: :create

private

  def max_number_of_groups_per_user
    if self.user && self.user.groups.count >= MAX_NUMBER_OF_GROUPS_PER_USER
      errors.add :group, "You can only have ${MAX_NUMBER_OF_GROUPS_PER_USER} groups at most"
    end
  end
end
