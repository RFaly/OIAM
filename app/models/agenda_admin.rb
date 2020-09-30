class AgendaAdmin < ApplicationRecord
	belongs_to :cadre_info
	belongs_to :admin, optional: true
	 def start_time
        self.entretien_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end
end
