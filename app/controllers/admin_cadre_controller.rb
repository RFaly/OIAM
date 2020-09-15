class AdminCadreController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end

  def send_message
  end

  def entretien_fit
    @cadres = current_admin.cadre_infos
  end

  def show_entretien_cadre
    @cadre = CadreInfo.find_by(id:params[:id])
  end

  def coaching_workshop
  end

  def events
  end

  def message
  end


  def accept_workshop
  end

  def cancel_workshop
  end
end
