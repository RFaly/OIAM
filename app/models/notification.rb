class Notification < ApplicationRecord
	before_create :confirmation_token

	belongs_to :client, optional: true
	belongs_to :cadre, optional: true

	def cadre_info
		return Cadre.find_by_id(self.medel_id).cadre_info
	end

	def offre_job
		return OffreJob.find_by_id(self.medel_id)
	end

	private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
    self.link += "&secure=#{self.confirm_token}"
  end

=begin
#notifaka (FOR search code to create a notification)
object: title of notification
message: content of notification
link: link to redirect on click notice
genre: { type of notice
	=== CADRE ====
	1: [medel_id: offre_job ] add to received job
	2: [medel_id: offre_job] add to suivi recrutement
	3: [medel_id: offre_job ] add to suivi_recrutement
	=== CLIENT ===
	1: suivi recrutement [medel_id: cadre ] accepte suivi recrutement
	2: suivi recrutement [medel_id: cadre] promesse validé
	3: postule candidat [medel_id: cadre]
	4: facture
}
view: false if not view

helpers.updateNotification(params[:secure])

notice = Notification.find_by_confirm_token(params[:secure])
unless notice.nil?
	notice.update(view:true)
end


=end

end
