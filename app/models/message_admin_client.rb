class MessageAdminClient < ApplicationRecord
	belongs_to :admin
	belongs_to :client
	validates :content, presence: true
end
