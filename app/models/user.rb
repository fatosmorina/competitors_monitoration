class User < ApplicationRecord

  has_many :groups, dependent: :destroy

  validates_presence_of :name, :email

end
