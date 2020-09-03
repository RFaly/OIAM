class CadreInfo < ApplicationRecord
	belongs_to :cadre, optional: true
	has_one :agenda_admin
	belongs_to :region, optional: true
	belongs_to :country, optional: true
	belongs_to :ville, optional: true
end

