module AdminCadreHelper
	def updateNotification(notice_token)
		notice = Notification.find_by_confirm_token(notice_token)
		unless notice.nil?
			notice.update(view:true)
		end
	end
end
