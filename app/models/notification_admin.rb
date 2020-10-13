class NotificationAdmin < ApplicationRecord
	has_many :notification_see_admins
  has_many :admins, through: :notification_see_admins
end
