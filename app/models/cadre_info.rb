class CadreInfo < ApplicationRecord
	has_one :agenda_admin
	
	belongs_to :cadre, optional: true
	belongs_to :admin, optional: true

	belongs_to :region, optional: true
	belongs_to :country, optional: true
	belongs_to :ville, optional: true
	belongs_to :metier, optional: true
end
