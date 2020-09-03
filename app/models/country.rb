class Country < ApplicationRecord
	has_many :regions
	has_many :cadre_infos
end
