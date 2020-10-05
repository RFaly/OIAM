class Formation < ApplicationRecord
	has_many :facture_formations
  has_many :cadres, through: :facture_formations
end
