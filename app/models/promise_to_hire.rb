class PromiseToHire < ApplicationRecord
	before_create :confirmation_token
	after_create :notifed_admin_if_first_candidate

	belongs_to :cadre
	belongs_to :offre_job

	has_one :facture

	delegate :url_helpers, to: 'Rails.application.routes'


	validates :date_poste, presence: true
	validates :remuneration_fixe, presence: true
	validates :remuneration_fixe_date, presence: true
	validates :remuneration_avantage, presence: true
	validates :date_de_validite, presence: true

	
	def notifed_admin_if_first_candidate
		if self.offre_job.offre_for_candidates.count == 1			
			ProcessedHistory.create(
        image: "/image/profie.png",
        message: "PROMESSE D'EMBAUCHE",
        link: "<a href='#{url_helpers.cp_show_promise_path(self.id)}'>VOIR</a>",
        is_client:true,
        genre: 1
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



