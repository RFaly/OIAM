class OffreJob < ApplicationRecord
	# after_create :notified_admin
	delegate :url_helpers, to: 'Rails.application.routes'

	belongs_to :client
	belongs_to :metier
	
	has_many :promise_to_hires
  has_many :cadres, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :cadres, through: :offre_for_candidates, dependent: :destroy

  has_many :favorite_jobs
  has_many :cadres, through: :favorite_jobs, dependent: :destroy

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

	def limite_date
		(self.created_at + 15.days).strftime("%d/%m/%Y")
	end

	# def notified_admin
	# 	name_entreprise = self.client.entreprise.name
	# 	NotificationAdmin.create(
	# 		object: "#{name_entreprise}",
	# 		message: "#{name_entreprise} a publié une nouvelle offre d'emploi.",
	# 		# link: "#{url_helpers.admin_client_show_offer_path(self.id,notification:"offre")}",
	# 		link:"/",
	# 		genre: 1,
	# 		medel_id: self.id
	# 	)
	# end

	def type_deplacement_name
		case self.type_deplacement
		when "1"
		  "Nationaux"
		when "2"
		  "Internationaux"
		when "3"
		  "Régionaux"
		when "0"
		  "Pas de déplacements"
		end
	end
	
	# use in cadre
	def is_in_my_favorite(cadre)
		return FavoriteJob.find_by(offre_job:self, cadre:cadre)
	end

	# pour verifier si le candidat est dans le job et peut postuler
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

	#use in clien dashbord
	def my_top_five_candidates
		return self.offre_for_candidates.where(accepted_postule:true)
	end

	def self.offre_dispos
		offre_disponibles = []
		
		OffreJob.where(is_publish:true).all.each do |offre_job|
			if offre_job.promise_to_hires.empty?
				offre_disponibles.push(offre_job)
			elsif !offre_job.promise_to_hires.where(repons_cadre: nil).empty?
				offre_disponibles.push(offre_job)
			end
		end

		return offre_disponibles
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
