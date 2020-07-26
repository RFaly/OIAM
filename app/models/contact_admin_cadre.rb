class ContactAdminCadre < ApplicationRecord
	belongs_to :admin
	belongs_to :cadre
	has_many :message_admin_cadres
	
end
