class NotificationsController < ApplicationController
	#cron job for entretien
  def entretien_client_fit
  	current_date = DateTime.now.utc

  	agendaClients = AgendaClient.where(notifed:false)
  	agendaClients.each do |agendaClient|
      # si la date de l'entretien est passé
	    if agendaClient.entretien_date < current_date
	    	oFc = agendaClient.offre_for_candidate
        message = ""
        if agendaClient.repons_client == true && agendaClient.repons_cadre == true && agendaClient.alternative.nil?
          message = "Vous avez rencontré #{oFc.cadre.cadre_info.first_name} #{oFc.cadre.cadre_info.last_name}, comment s'est déroulé votre entretien ?"
        elsif agendaClient.repons_client == true && agendaClient.repons_cadre == true && !agendaClient.alternative.nil?
          message = "La date de l'entretien avec #{oFc.cadre.cadre_info.first_name} #{oFc.cadre.cadre_info.last_name} est passée, le candidat a proposé une autre date."
        elsif agendaClient.repons_cadre.nil?
          message = "La date de l'entretien avec #{oFc.cadre.cadre_info.first_name} #{oFc.cadre.cadre_info.last_name} est passée mais ce candidat n'a pas donné de réponse à votre demande d’entretien."
          Notification.create(
            cadre: oFc.cadre,
            object: "Suivi recrutement",
            message: "La date de l'entretien avec l'entreprise #{oFc.offre_job.client.entreprise.name} est passée mais vous n'avez donner aucune réponse à la demande d’entretien.",
            link: "#{show_recrutment_monitoring_path(oFc.id,notification:"entretien")}",
            genre: 1,
            medel_id: oFc.cadre.id,
            view: false
          )
        end
        unless message.empty?
  				Notification.create(
  					client: oFc.offre_job.client,
  					object: "Suivi recrutement",
  					message: message,
  					link: "#{recruitment_show_cadre_path(oFc.id,notification:"entretien")}",
  					genre: 1,
  					medel_id: oFc.cadre.id,
  					view: false
  				)
  	    	agendaClient.update(notifed:true)
        end
	    end
  	end

  	# pour entretien fit admin #cron job for entretien fit
  	agendaAdmins = AgendaAdmin.where(notifed:false)
  	agendaAdmins.each do |agendaAdmin|
      # si la date de l'entretien est passé
	    if agendaAdmin.entretien_date < current_date
				cadre_info = agendaAdmin.cadre_info
				NotificationAdmin.create(
					object: "Suivi entretien fit",
					message: "Vous avez rencontré #{cadre_info.first_name} #{cadre_info.last_name[0].upcase}, comment s'est déroulé votre entretien ?",
					link: "#{post_avis_candidats_fit_path(cadre_info.id,notification:"fit")}",
					genre: 2
				)
	    	agendaAdmin.update(notifed:true)
	    end
  	end

  end

  def number_notice
  	@number_notice_client = 0
  	unless current_client.nil?
  		@number_notice_client = current_client.notifications.where(view:false).count
  	end
  	@number_notice_cadre = 0
  	unless current_cadre.nil?
  		@number_notice_cadre = current_cadre.notifications.where(view:false).count
  	end
  end

  def number_message
  	@number_message_client = 0
  	unless current_client.nil?
  		@number_message_client = current_client.number_message_not_see
  	end
  	@number_message_cadre = 0
  	unless current_cadre.nil?
  		@number_message_cadre = current_cadre.number_message_not_see
  	end
  end

end
