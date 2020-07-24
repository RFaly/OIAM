class MessageAdminCadre < ApplicationRecord
	belongs_to :admin
	belongs_to :cadre
	validates :content, presence: true
end
