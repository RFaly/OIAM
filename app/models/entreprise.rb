class Entreprise < ApplicationRecord
	belongs_to :client
	
	after_create :notified_admin

  delegate :url_helpers, to: 'Rails.application.routes'

	def notified_admin
	  client = self.client
	  # NotificationAdmin.create(
	  #   object: "Un nouveau client vient de s'inscrire.",
	  #   message: "#{client.first_name} #{client.last_name} a crée un compte pour l'entreprise #{self.name}.",
	  #   # link: "#{url_helpers.admin_client_show_client_path(client.id,notification:"client")}",
	  #   link: "/",
	  #   genre: 5,
	  #   medel_id: client.id
	  # )
	end
end
