class AgendaClient < ApplicationRecord
	belongs_to :offre_for_candidate

	# after_create :notifed_admin_if_first_candidate

	# 5. Recherche et sélectionne des candidats
	# def notifed_admin_if_first_candidate
	# 	if self.offre_for_candidate.offre_job.offre_for_candidates.where(accepted_postule:true).count == 1
	# 		ProcessedHistory.create(
    #     image: "/image/work.png",
    #     message: "SELECTION CANDIDATS",
    #     link: "<a href='#{clients_bp_offre_job_no_cadre_path(self.offre_for_candidate.offre_job.id)}'>VOIR</a>",
    #     is_client:true,
    #     genre: 1
    #   )
	# 	end
	# end
	
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
