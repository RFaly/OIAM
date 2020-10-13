class ContactAdminCadre < ApplicationRecord
	belongs_to :admin
	belongs_to :cadre
	has_many :message_admin_cadres
	
	def mp_admin_not_see
		return self.message_admin_cadres.where(admin_see:false).count
	end
end
