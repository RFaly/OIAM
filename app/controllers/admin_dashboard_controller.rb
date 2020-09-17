class AdminDashboardController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end

  def agenda
  end

  def offer
  end

  def candidate
    @cadres = CadreInfo.where(admin_id:nil)
  end

  def show_candidate
    @cadre = CadreInfo.find_by(id:params[:id])
  end

  def tache
  end

  # SOUS MENU TACHES
  def factures
  end

  def relances
  end

  def taches
  end

  def add_favorite_cadre
    @cadre = CadreInfo.find_by(id:params[:id])
    @cadre.update(admin:current_admin)
    redirect_to post_avis_candidats_fit_path(@cadre.id)
  end

  def rmv_favorite_cadre
    @cadre = CadreInfo.find_by(id:params[:id])
    @cadre.update(admin_id:nil)
    redirect_to admin_dashboard_candidate_path
  end

end
