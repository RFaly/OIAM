class City < ApplicationRecord
	belongs_to :region
	has_many :cadre_infos
end
