class Notification < ApplicationRecord
  validates_presence_of :user
  belongs_to :user

  scope :unread, ->{ where(read_at: nil) }

end
