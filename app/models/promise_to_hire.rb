class PromiseToHire < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job

	has_one :facture

	validates :date_poste, presence: true
	validates :remuneration_fixe, presence: true
	validates :remuneration_fixe_date, presence: true
	validates :remuneration_avantage, presence: true
	validates :date_de_validite, presence: true
end
