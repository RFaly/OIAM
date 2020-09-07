class Metier < ApplicationRecord
	has_many :cadre_infos
	has_many :offre_jobs
end
