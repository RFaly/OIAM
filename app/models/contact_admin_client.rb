class ContactAdminClient < ApplicationRecord
	belongs_to :admin
	belongs_to :client
	has_many :message_admin_clients

end
