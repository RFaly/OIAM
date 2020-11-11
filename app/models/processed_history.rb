class ProcessedHistory < ApplicationRecord
	before_create :confirmation_token

	belongs_to :client, optional: true
	belongs_to :cadre_info, optional: true

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end

# rails generate migration AddUserToProcessedHistory
