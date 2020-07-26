class MessageAdminClient < ApplicationRecord
	belongs_to :admin
	belongs_to :client
	belongs_to :contact_admin_client
	
	validates :content, presence: true
end
