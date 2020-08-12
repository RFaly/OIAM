class OffreForCandidate < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job
	has_many :agenda_clients
# rails g model OffreForCandidates
# status:string
# is_recrute:boolean
# status: refusé-accepté(next etap)-en_attente
# accepted_postule: recruteur à accepter sa demande de postulation
end
