class FactureFormation < ApplicationRecord
	belongs_to :formation
	belongs_to :cadre
end
