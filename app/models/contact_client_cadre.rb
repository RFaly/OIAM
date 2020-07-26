class ContactClientCadre < ApplicationRecord
	belongs_to :cadre
	belongs_to :client
	has_many :message_client_cadres

end
