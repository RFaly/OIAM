class CadreInfo < ApplicationRecord
	before_create :confirmation_token
	has_one :agenda_admin
	
	belongs_to :cadre, optional: true
	belongs_to :admin, optional: true

	belongs_to :region, optional: true
	belongs_to :country, optional: true
	belongs_to :ville, optional: true
	belongs_to :metier, optional: true


  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end


end
