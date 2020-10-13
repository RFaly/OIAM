class ContactAdminClient < ApplicationRecord
	belongs_to :admin
	belongs_to :client
	has_many :message_admin_clients

	def mp_admin_not_see
		return self.message_admin_clients.where(admin_see:false).count
	end

end
