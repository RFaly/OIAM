class AdminDashboardController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end

  def agenda
    @agendas = AgendaAdmin.all
  end

  def statistics
    cadreInfos = CadreInfo.all
    
    c_admis = cadreInfos.where(is_recrute:true)
    c_no_admis = cadreInfos.where(is_recrute:false)
    en_cours = cadreInfos.where(is_recrute:nil)
    
    total = cadreInfos.count

    @c_admis = (c_admis.count * 100.0)/ total
    @c_no_admis = (c_no_admis.count * 100.0)/ total
    @en_cours = (en_cours.count * 100.0)/ total

  end

  def contact_us
    @contactUs = ContactU.all
  end

  def subscribers
    @subscribers = Subscriber.all
  end

  def offer
  end

  def candidate
    @cadres = CadreInfo.where(admin_id:nil)
    @cadres = @cadres.where.not(score_potential:nil)
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

  # def add_favorite_cadre
  #   @cadre = CadreInfo.find_by(id:params[:id])
  #   if @cadre.admin.nil?
  #     @cadre.update(admin:current_admin)
  #     flash[:notice] = "Vous êtes responsable de #{@cadre.last_name} #{@cadre.first_name} maintenant."
  #     redirect_to post_avis_candidats_fit_path(@cadre.id)
  #   else
  #     flash[:notice] = "Oupss! ... "
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  # def rmv_favorite_cadre
  #   @cadre = CadreInfo.find_by(id:params[:id])
  #   unless @cadre.admin.nil?
  #     @cadre.update(admin_id:nil)
  #   end
  #   flash[:notice] = "Vous n'êtes plus responsable de #{@cadre.last_name} #{@cadre.first_name} maintenant."
  #   redirect_to admin_dashboard_candidate_path
  # end

end
