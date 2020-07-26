class MessageAdminClient < ApplicationRecord
	belongs_to :contact_admin_client
	validates :content, presence: true
end
