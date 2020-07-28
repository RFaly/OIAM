class ContactClientCadre < ApplicationRecord
	belongs_to :cadre
	belongs_to :client
	has_many :message_client_cadres

	def mp_client_not_see
		return self.message_client_cadres.where(client_see:false).count
	end

	def mp_cadre_not_see
		return self.message_client_cadres.where(cadre_see:false).count
	end
end
