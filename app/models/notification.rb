class Notification < ApplicationRecord
	before_create :confirmation_token

	belongs_to :client, optional: true
	belongs_to :cadre, optional: true

	def cadre_info
		return Cadre.find_by_id(self.medel_id).cadre_info
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
	2: [medel_id: promise_to_hire] add to suivi recrutement
	3: [medel_id: offre_job ] add to suivi_recrutement
	=== CLIENT ===
	1: suivi recrutement [medel_id: offre_job ] accepte suivi recrutement
	2: suivi recrutement [medel_id: offre_job] promesse validé
	3: postule candidat [medel_id: cadre]
	4: facture
}
view: false if not view
=end

end
