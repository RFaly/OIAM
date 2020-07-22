class PromiseToHire < ApplicationRecord
	belongs_to :client
	belongs_to :cadre

	validates :birthday_cadre, presence: true
	validates :birthplace_cadre, presence: true
	validates :ns_sociale_cadre, presence: true
	validates :date_poste, presence: true
	validates :remuneration_fixe, presence: true
	validates :remuneration_fixe_date, presence: true
	validates :remuneration_variable, presence: true
	validates :remuneration_var_info, presence: true
	validates :price, presence: true
	validates :remuneration_avantage, presence: true
	validates :date_de_validite, presence: true
	validates :signature_entreprise, presence: true
	validates :signature_candidat, presence: true
end
