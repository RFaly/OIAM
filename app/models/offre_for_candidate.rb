class OffreForCandidate < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job
	has_many :agenda_client
# rails g model OffreForCandidates status:string is_recrute:boolean
# status: refuser-accepter(next etap)-en_attente
end
