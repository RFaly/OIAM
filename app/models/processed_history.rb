class ProcessedHistory < ApplicationRecord
	before_create :confirmation_token

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
