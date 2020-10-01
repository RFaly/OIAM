class AdminMainController < ApplicationAdminController
  before_action :authenticate_admin!
  def home
  end

  def messaging
  end

  def notification
    @notifications = Notification.where(admin: current_admin)
  end

  def my_profil
  	
  end
end
