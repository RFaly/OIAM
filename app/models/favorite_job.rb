class FavoriteJob < ApplicationRecord
	belongs_to :cadre
	belongs_to :offre_job
end
