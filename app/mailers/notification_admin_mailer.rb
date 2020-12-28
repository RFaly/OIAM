class NotificationAdminMailer < ApplicationMailer
	#un nouvelle candidat demande un entretien-fit à validé

	def demande_entretien_fit
	    @admin = Admin.first
	    mail(to: @admin.email, subject: "Nouvelle candidat pour l'entretien-fit")
	end
end
# NotificationAdminMailer.demande_entretien_fit(@cadreInfo).deliver_now
