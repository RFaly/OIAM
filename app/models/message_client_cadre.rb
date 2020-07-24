class MessageClientCadre < ApplicationRecord
	belongs_to :cadre
	belongs_to :client
	validates :content, presence: true
end
