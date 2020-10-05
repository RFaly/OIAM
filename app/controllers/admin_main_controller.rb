class AdminMainController < ApplicationAdminController
  before_action :authenticate_admin!
  def home
  end

  def messaging
  end

  def notification
    @notifications = current_admin.notifications.order("created_at DESC")
  end

  def my_profil

  end

  def message_candidat

  end

  def message_recruteur

  end
end
