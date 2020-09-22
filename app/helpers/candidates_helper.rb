module CandidatesHelper
	def updateNotification(notice_id)
		notice = Notification.find_by_confirm_token(notice_id)
		unless notice.nil?
			notice.update(view:true)
		end
	end
end
