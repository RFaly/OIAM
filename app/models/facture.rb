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

		Notification.create(
      client: self.client,
      link: "#{paye_my_bills_path(self.id,notification:"entretien")}",
      object: "Facture OIAM",
      message: "Précalcul honoraires OIAM",
      genre: 2,
      view: false
    )
	end

	def status
		if self.ov.nil?
			"trosa"
		else
			"paye"
		end
	end

	def numero_facture
		day = self.created_at.day < 10 ? "0"+ self.created_at.day.to_s : day = self.created_at.day
    
    month = self.created_at.month < 10 ? month = "0"+ self.created_at.month.to_s : month = self.created_at.month
    
    year = self.created_at.year

    facture_id = self.id.to_s

    while (facture_id.length < 5) do
      facture_id = "0"+ facture_id
    end

    return "FACT-#{year}#{month}#{day}-#{facture_id}"
    
	end
end
