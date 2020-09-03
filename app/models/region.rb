class Region < ApplicationRecord
	has_many :cities
	has_many :cadre_infos
	belongs_to :country
end
