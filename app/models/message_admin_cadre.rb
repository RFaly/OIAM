class MessageAdminCadre < ApplicationRecord
	belongs_to :admin
	belongs_to :cadre
	belongs_to :contact_admin_cadre
	
	validates :content, presence: true
end
