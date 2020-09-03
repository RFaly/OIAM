class Region < ApplicationRecord
	has_many :cities
	belongs_to :country
end
