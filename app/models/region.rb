class Region < ApplicationRecord
	has_many :villes
	has_many :cadre_infos
	belongs_to :country
end
