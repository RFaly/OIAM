module AdminClientHelper
	def updateNotification(notice_token,current_admin)
		notice = NotificationAdmin.find_by_confirm_token(notice_token)
		unless notice.nil?
			if notice.notification_see_admins.where(admin: current_admin, notification_admin:notice).empty?
				NotificationSeeAdmin.create(admin: current_admin, notification_admin:notice)
			end
		end
	end
end
