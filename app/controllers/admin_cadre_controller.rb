class AdminCadreController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end

  def send_message
  end

  def entretien_fit
  end

  def coaching_workshop
  end

  def events
  end
end
