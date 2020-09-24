class Facture < ApplicationRecord
	belongs_to :promise_to_hire
	belongs_to :client

	after_create :create_notification

	private

	def create_notification
		Notification.create(client: self.client,link: "#{paye_my_bills_path(self.id,notification:"entretien")}",genre: 2,view: false)
	end

end
