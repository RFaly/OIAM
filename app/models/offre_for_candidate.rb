class OffreForCandidate < ApplicationRecord
	after_create :notifed_admin_if_first_candidate
	belongs_to :cadre
	belongs_to :offre_job
	has_many :agenda_clients
# rails g model OffreForCandidates
# status:string
# is_recrute:boolean
# # status: 
# 	"accepted"
# 	"refused"
# 	"waiting"
	
# accepted_postule: recruteur à accepter sa demande de postulation

	def next_stape
		self.update(etapes: self.etapes + 1)
	end

	def notifed_admin_if_first_candidate
		if self.offre_job.offre_for_candidates.count == 1			
			ProcessedHistory.create(
        image: "/image/profie.png",
        message: "SELECTION CANDIDATS",
        link: "#",
        is_client:true,
        genre: 1
      )
		end
	end

end
