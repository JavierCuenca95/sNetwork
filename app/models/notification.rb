class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :post

  validates :user_id, :notified_by_id, :post_id, :type_notification, presence: true
end
