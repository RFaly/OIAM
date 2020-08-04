class OffreForCandidate < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job
	has_many :agenda_clients
# rails g model OffreForCandidates
# status:string
# is_recrute:boolean
# status: refuser-accepter(next etap)-en_attente
# accepted_postule: recruteur à accepter sa demande de postulation
end


=begin

	AgendaClient
	# entretien_date:string
	# entretien_time:string
	# adresse:string
	# recruteur:string
	# alternative:string
	# is_accepted:boolean #accepter la demande d'entretien

=end