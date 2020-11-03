class CadreInfo < ApplicationRecord
	before_create :confirmation_token
	has_one :agenda_admin

	belongs_to :cadre, optional: true
	belongs_to :admin, optional: true

	belongs_to :region, optional: true
	belongs_to :country, optional: true
	belongs_to :ville, optional: true
	belongs_to :metier, optional: true

	#constance score minimum test potential
	def self.min_score
		500
	end

	def status_state
		if self.is_recrute.nil?
			"en cours"
		elsif self.is_recrute
			"admis"
		else
			"non admis"
		end
	end

	def not_admited_test
		if self.score_fit.nil?
			"potential_test"
		else
			"fit_test"
		end
	end

	def mobilite_name
		case self.mobilite
		when "1"
		  "NATIONALE"
		when "2"
		  "INTERNATIONALE"
		when "3"
		  "LOCALE"
		when "0"
		  "PAS DE DÉPLACEMENT"
		end
	end

	def compatibilite
		unless self.score_fit.nil?
			self.score_fit * 10
		end
	end

	def promise_not_reponded
		pth = self.cadre.promise_to_hires.where(repons_cadre:nil).first
		if pth.offre_job.nil?
			[pth.date_de_validite," ~ "]
		else
			[pth.date_de_validite,pth.offre_job.date_poste]
		end
	end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
