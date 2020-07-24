class AgendaClient < ApplicationRecord
	belongs_to :offre_for_candidate
	#entretien_date:string entretien_time:string adresse:string recruteur:string alternative:string is_accepted:boolean
end
