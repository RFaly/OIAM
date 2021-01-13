class NotificationAdminMailer < ApplicationMailer
	#un nouvelle candidat demande un entretien-fit à validé

	def demande_entretien_fit(cadreInfo)
		@admin = Admin.first
		@cadreInfo = cadreInfo
	    mail(to: @admin.email, subject: "Nouvelle candidat pour l'entretien-fit")
	end

	def confirm_pay_facture(client,facture)
		@client = client
		@facture = client
		@admin = Admin.first
		mail(to: @admin.email, subject: "Un client atteste de régler une facture par virement dans les 15 jours.")
	end

	def pay_facture(client,facture)
		# L'entreprise #{name_entreprise} a payé sa facture oiam.
		@client = client
		@facture = facture
		@admin = Admin.first
	    mail(to: @admin.email, subject: "Un client a payé sa facture oiam.")
	end
end
# NotificationAdminMailer.demande_entretien_fit(@cadreInfo).deliver_now

