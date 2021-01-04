class NotificationCadreMailer < ApplicationMailer

	def demande_entretien_fit_valide(cadre_info)
	    @cadre_info = cadre_info
	    mail(to: @cadre_info.mail, subject: "A valider votre date d'entretien") 
	end

	# 1ère demande d'entretien
	def demande_entretien_job(cadre_info,offre)
		@cadre_info = cadre_info
		@offre = offre
	    mail(to: @cadre_info.mail, subject: "Vous avez une nouvelle demande d'entretien avec jj")
	end

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def accepted_entretien_job(cadre_info,offre,agendaClient)
		@cadre_info = cadre_info
		@offre = offre
		@agendaClient = agendaClient
    	mail(to: @cadre_info.mail, subject: "Le recruteur a accepter l'entretien")
	end

	def edit_entretien_job(cadre_info,offre,agendaClient)
		@cadre_info = cadre_info
		@agendaClient = agendaClient
		@offre = offre
    	mail(to: @cadre_info.mail, subject: "Le recruteur a proposer une autre date pour l'entretien")
	end

	def refused_entretien_job(cadre_info,offre,agendaClient)
		@agendaClient = agendaClient
		@offre = offre
		@cadre_info = cadre_info
    	mail(to: @cadre_info.mail, subject: "Le recruteur a reffusé l'entretien")
	end


	# repons du recruteur après chaque entretien
	def recrutement_accepted(cadre_info,offre,etapes)
		@offre = offre
		@etapes = etapes
		@cadre_info = cadre_info
    	mail(to: @cadre_info.mail, subject: "Le recruteur a validé votre candidature pour la #{etapes} étape.")
	end

	# def recrutement_waiting(cadre_info,offre)
	# 	@cadre_info = cadre_info
 #    	mail(to: @cadre_info.mail, subject: "Le recruteur a reffusé l'entretien")
	# end

	def recrutement_refused(cadre_info,offre,raison)
		@offre = offre
		@raison = raison
		message = "Le recruteur a refusé votre candidature."
		unless raison.nil?
			message = "Le recruteur a envoyé la raison du refus de votre candidature."
		end

		@cadre_info = cadre_info
    	mail(to: @cadre_info.mail, subject: "#{message}")
	end

	def promise_to_hire_to_cadre(cadre_info,promise)
		@cadre_info = cadre_info
		@promise = promise
    	mail(to: @cadre_info.mail, subject: "Le recruteur a envoyer une promesse d'embauche")
	end

	def update_promise_to_hire_to_cadre(cadre_info,promise)
		@promise = promise
		@cadre_info = cadre_info
    	mail(to: @cadre_info.mail, subject: "Le recruteur a mis à jour la promesse d'embauche")
	end
end

# 
# 
# NotificationCadreMailer.recrutement_waiting(cadre_info,offre,raison).deliver_now