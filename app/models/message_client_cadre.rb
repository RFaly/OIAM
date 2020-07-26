class MessageClientCadre < ApplicationRecord
	belongs_to :cadre
	belongs_to :client
	belongs_to :contact_client_cadre
	
	validates :content, presence: true
end
