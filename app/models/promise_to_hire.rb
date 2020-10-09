class PromiseToHire < ApplicationRecord
	before_create :confirmation_token
	after_update :notified_admin

	delegate :url_helpers, to: 'Rails.application.routes'

	belongs_to :cadre
	belongs_to :offre_job

	has_one :facture

	validates :date_poste, presence: true
	validates :remuneration_fixe, presence: true
	validates :remuneration_fixe_date, presence: true
	validates :remuneration_avantage, presence: true
	validates :date_de_validite, presence: true


	def notified_admin
		offreJob = self.offre_job
		name_entreprise = offreJob.client.entreprise.name
		Admin.all.each do |admin|
			Notification.create(
				admin: admin,
				object: "#{name_entreprise}",
				message: "#{name_entreprise} vien d'embaucher un candidat.",
				link: "#{url_helpers.post_avis_candidats_fit_path(self.cadre.id,notification:"fit")}",
				genre: 1,
				medel_id: offreJob.id,
				view: false
			)
		end
	end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
