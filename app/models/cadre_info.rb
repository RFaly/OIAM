class CadreInfo < ApplicationRecord
	belongs_to :cadre, optional: true
	has_one :agenda_admin
end
