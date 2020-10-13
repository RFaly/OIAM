class ContactU < ApplicationRecord
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :society, presence: true
	validates :function, presence: true
	validates :email, presence: true
	validates :telephone, presence: true
	validates :how, presence: true
	validates :message, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

end
