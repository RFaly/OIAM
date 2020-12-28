class NotificationClientMailer < ApplicationMailer

	def candidate_postule_offre(client)
    @client = client
    mail(to: @client.mail, subject: "A postuler a votre offre d'emploi")
	end

	def accepted_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    mail(to: @client.mail, subject: "Le candidat a accepter l'entretien")
	end

	def edit_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    mail(to: @client.mail, subject: "Le candidat a proposer une autre date pour l'entretien")
	end

	def refused_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    mail(to: @client.mail, subject: "Le candidat a reffusé l'entretien")
	end

end
# NotificationClientMailer.accepted_entretien_job(cadre_info,offre).deliver_now
# NotificationClientMailer.edit_entretien_job(cadre_info,offre).deliver_now
# NotificationClientMailer.refused_entretien_job(cadre_info,offre).deliver_now