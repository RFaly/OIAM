class NotificationCadreMailer < ApplicationMailer

	def demande_entretien_fit_valide(cadre_info)
	    @cadre_info = cadre_info
	    mail(to: @cadre_info.mail, subject: "A valider votre date d'entretien") 
	end

	# 1ère demande d'entretien
	def demande_entretien_job(cadre_info,offre)
		@cadre_info = cadre_info
	    mail(to: @cadre_info.mail, subject: "Vous avez une nouvelle demande d'entretien avec jj")
	end

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	def accepted_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    	mail(to: @client.mail, subject: "Le recruteur a accepter l'entretien")
	end

	def edit_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    	mail(to: @client.mail, subject: "Le recruteur a proposer une autre date pour l'entretien")
	end

	def refused_entretien_job(cadre_info,offre,agendaClient)
		@client = offre.client
    	mail(to: @client.mail, subject: "Le recruteur a reffusé l'entretien")
	end

end

# NotificationCadreMailer.accepted_entretien_job(cadre_info,offre).deliver_now
# NotificationCadreMailer.edit_entretien_job(cadre_info,offre).deliver_now
# NotificationCadreMailer.refused_entretien_job(cadre_info,offre).deliver_now