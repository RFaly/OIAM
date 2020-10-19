class NotificationsController < ApplicationController
	#cron job for entretien
  def entretien_client_fit
  	current_date = DateTime.now.utc
  	# pour entretien cadre client #cron job for cadre client
  	agendaClients = AgendaClient.where(notifed:false,repons_client:true,repons_cadre:true,alternative:nil)
  	agendaClients.each do |agendaClient|
      # si la date de l'entretien est passé
	    if agendaClient.entretien_date < current_date
	    	oFc = agendaClient.offre_for_candidate
				Notification.create(
					client: oFc.offre_job.client,
					object: "Suivi recrutement",
					message: "Vous avez rencontré #{oFc.cadre.cadre_info.first_name} #{oFc.cadre.cadre_info.last_name}, comment s'est déroulé votre entretien ?",
					link: "#{recruitment_show_cadre_path(oFc.id,notification:"entretien")}",
					genre: 1,
					medel_id: oFc.cadre.id,
					view: false
				)
	    	agendaClient.update(notifed:true)
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

end
