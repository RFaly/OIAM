class AgendaAdmin < ApplicationRecord
	after_create :notified_admin
	belongs_to :cadre_info
	belongs_to :admin, optional: true


	delegate :url_helpers, to: 'Rails.application.routes'


	def notified_admin
		cadre_info = self.cadre_info
		if cadre_info.admin.nil?
			Admin.all.each do |admin|
				Notification.create(
				admin: admin,
				object: "#{cadre_info.first_name} #{cadre_info.last_name}",
				message: "#{cadre_info.first_name} #{cadre_info.last_name[0].upcase}. a proposé une date pour l'entretien.",
				link: "#{url_helpers.post_avis_candidats_fit_path(cadre_info.id,notification:"fit")}",
				genre: 2,
				medel_id: cadre_info.id,
				view: false
			)	
			end
		else
			Notification.create(
				admin: cadre_info.admin,
				object: "#{cadre_info.first_name} #{cadre_info.last_name}",
				message: "#{cadre_info.first_name} #{cadre_info.last_name[0].upcase}. a proposé une date pour l'entretien.",
				link: "#{url_helpers.post_avis_candidats_fit_path(cadre_info.id,notification:"fit")}",
				genre: 2,
				medel_id: cadre_info.id,
				view: false
			)
		end
	end

end
