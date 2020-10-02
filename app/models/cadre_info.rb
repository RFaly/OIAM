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

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end


end
