class NotificationSeeAdmin < ApplicationRecord
	belongs_to :admin
	belongs_to :notification_admin
end
