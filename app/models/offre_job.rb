class OffreJob < ApplicationRecord
	belongs_to :client
	
	has_many :promise_to_hires
  has_many :cadres, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :cadres, through: :offre_for_candidates

  has_many :favorite_jobs
  has_many :cadres, through: :favorite_jobs

	validates :country, presence: true
	validates :region, presence: true
	validates :department, presence: true
	validates :intitule_pote, presence: true
	validates :descriptif_mission, presence: true
	validates :rattachement, presence: true
	validates :remuneration, presence: true
	validates :remuneration_anne, presence: true
	validates :type_deplacement, presence: true
	validates :date_poste, presence: true
	validates :question1, presence: true
	validates :question2, presence: true
	validates :numberEntretien, presence: true
	validates :question4, presence: true
	validates :question5, presence: true

	def is_in_my_favorite(cadre)
		return FavoriteJob.find_by(offre_job:self, cadre:cadre)
	end

	def is_in_this_job(cadre)
		return OffreForCandidate.find_by(offre_job:self,cadre:cadre)
	end

	def in_list_entretien(cadre)
		ofc = self.is_in_this_job(cadre)
		if ofc.nil?
			return nil
		else
			agenda_c = ofc.agenda_clients
			if agenda_c.empty?
				return nil
			else
				return agenda_c.order('created_at DESC')[0]
			end
		end
	end

	def next_stape
		self.update(etapes: self.etapes + 1)
	end

	# private
	# before_create :set_default_id_secure
 #  def set_default_id_secure
 #    if self.id_secure.blank?
 #      self.id_secure = SecureRandom.urlsafe_base64.to_s
 #    end
 #  end

end

# rails generate migration add_id_sercure_to_offre_jobs id_sercure:string
