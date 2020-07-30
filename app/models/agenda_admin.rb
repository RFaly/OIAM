class AgendaAdmin < ApplicationRecord
	belongs_to :cadre_info
	belongs_to :admin, optional: true
end
