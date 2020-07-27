class OffreJob < ApplicationRecord
	belongs_to :client
	
	has_many :promise_to_hires
  has_many :cadres, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :cadres, through: :offre_for_candidates

  has_many :favorite_jobs
  has_many :cadres, through: :favorite_jobs

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
