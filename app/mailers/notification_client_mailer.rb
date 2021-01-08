class NotificationClientMailer < ApplicationMailer

	def candidate_postule_offre(candidat,offre)
    @client = offre.client
    @candidat = candidat
    @offre = offre
    mail(to: @client.mail, subject: "A postuler a votre offre d'emploi")
	end

	def accepted_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
		@offre = offre
		@ofc = cadre_info.cadre.offre_for_candidates.find_by(offre_job_id: offre.id)
		@cadre_info = cadre_info
		@agendaClient = agendaClient
    mail(to: @client.mail, subject: "Le candidat a accepter l'entretien")
	end

	def edit_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
		@offre = offre
		@ofc = cadre_info.cadre.offre_for_candidates.find_by(offre_job_id: offre.id)
		@cadre_info = cadre_info
		@agendaClient = agendaClient
    mail(to: @client.mail, subject: "Le candidat a proposer une autre date pour l'entretien")
	end

	def refused_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
		@cadre_info = cadre_info
		@offre = offre
		@ofc = cadre_info.cadre.offre_for_candidates.find_by(offre_job_id: offre.id)
		@agendaClient = agendaClient
    mail(to: @client.mail, subject: "Le candidat a reffusé l'entretien")
	end

	def validate_promise(cadre_info,offre,promise)
		@client = offre.client
		@offre = offre
		@cadre_info = cadre_info
		@promise = promise
    mail(to: @client.mail, subject: "Le candidat a Validé la promesse d'embauche")
	end

end
# 
# NotificationClientMailer.edit_entretien_job(cadre_info,offre).deliver_now
# NotificationClientMailer.refused_entretien_job(cadre_info,offre).deliver_now