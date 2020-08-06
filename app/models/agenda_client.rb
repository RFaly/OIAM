class AgendaClient < ApplicationRecord
	belongs_to :offre_for_candidate

=begin

	AgendaClient
	# entretien_date:string
	# entretien_time:string
	# adresse:string
	# recruteur:string
	# alternative:string
	# repons_cadre et repons_client
	:boolean #accepter la demande d'entretien

=end
end
