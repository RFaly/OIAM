class Facture < ApplicationRecord
	after_create :notified_admin

	belongs_to :promise_to_hire
	belongs_to :client
	delegate :url_helpers, to: 'Rails.application.routes'

	def notified_admin
		promise = self.promise_to_hire
		offreJob = promise.offre_job
		name_entreprise = offreJob.client.entreprise.name
		NotificationAdmin.create(
			object: "#{name_entreprise}",
			message: "#{name_entreprise} a embaucher un candidat, facture précalcul honoraires OIAM",
			link: "#{url_helpers.admin_client_show_facture_path(self.id)}",
			genre: 1,
			medel_id: offreJob.id
		)
	end
end
