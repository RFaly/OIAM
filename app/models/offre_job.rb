class OffreJob < ApplicationRecord
	belongs_to :client
	validates :country, presence: true
	validates :region, presence: true
	validates :department, presence: true
	validates :intitule_pote, presence: true
	validates :descriptif_mission, presence: true
	validates :rattachement, presence: true
	validates :remuneration, presence: true
	validates :remuneration_anne, presence: true
	validates :type_deplacement, presence: true
	validates :date_poste, presence: true
	validates :question1, presence: true
	validates :question2, presence: true
	validates :question3, presence: true
	validates :question4, presence: true
	validates :question5, presence: true
end
