class Notification < ApplicationRecord
	before_create :confirmation_token

	belongs_to :client, optional: true
	belongs_to :cadre, optional: true
	belongs_to :admin, optional: true

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

helpers.updateNotification(params[:secure])

#notifaka (FOR search code to create a notification)
object: title of notification
message: content of notification
link: link to redirect on click notice

genre: { type of notice
	=== CADRE ====
	1: [medel_id: offre_job ] add to (received job +1)
	2: [medel_id: offre_job] add to (suivi recrutement +1)
	=== CLIENT ===
	1: suivi recrutement [medel_id: cadre ] (suivi recrutement +1)
	2: pour la facture ne pas afficher (facture +1)
	3: postule candidat [medel_id: cadre] (tsy apina aiza aiza)
	=== ADMIN ===
	1: offre_job
	2: cadre
}


view: false if not view

helpers.updateNotification(params[:secure])

notice = Notification.find_by_confirm_token(params[:secure])
unless notice.nil?
	notice.update(view:true)
end
=end

end
