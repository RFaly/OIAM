class MessageAdminCadre < ApplicationRecord
	belongs_to :contact_admin_cadre
	validates :content, presence: true
end
