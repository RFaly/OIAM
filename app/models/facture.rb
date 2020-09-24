class Facture < ApplicationRecord
	belongs_to :promise_to_hire
	belongs_to :client
end
