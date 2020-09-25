class PromiseToHire < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job

	has_one :facture

	validates :date_poste, presence: true
	validates :remuneration_fixe, presence: true
	validates :remuneration_fixe_date, presence: true
	validates :remuneration_avantage, presence: true
	validates :date_de_validite, presence: true

	before_create :confirmation_token

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
