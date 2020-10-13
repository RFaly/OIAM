class NotificationAdmin < ApplicationRecord
  before_create :confirmation_token

	has_many :notification_see_admins
  has_many :admins, through: :notification_see_admins

	private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
    self.link += "&secure=#{self.confirm_token}"
  end


end
