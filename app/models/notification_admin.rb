class NotificationAdmin < ApplicationRecord
  before_create :confirmation_token

	has_many :notification_see_admins
  has_many :admins, through: :notification_see_admins


  def view(current_admin)
    if self.notification_see_admins.where(admin: current_admin, notification_admin:self).empty?
      false
    else
      true
    end
  end

  def offre_job
    return OffreJob.find_by_id(self.medel_id)
  end

  def client_image
    c = Client.find_by_id(self.medel_id)
    if c.image.nil?
      "/image/profie.png"
    else
      c.image
    end
  end

	private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
    self.link += "&secure=#{self.confirm_token}"
  end


end
