class OffreForCandidate < ApplicationRecord
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

end
