class AdminDashboardController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end

  def agenda
    @agendas = AgendaAdmin.all
  end

  def statistics
    cadreInfos = CadreInfo.all
    @clientsNbr = Client.count

    @cadresNbr = Cadre.count

    @recruteNbr = Cadre.joins(:promise_to_hires).where(promise_to_hires: {repons_cadre:true}).uniq.count
    @recrutePercent = (@recruteNbr*100)/@cadresNbr

    @annoncesNbr = OffreJob.count

# REPONS_CADRE

    c_admis = cadreInfos.where(is_recrute:true)

    c_refuse = cadreInfos.where(is_recrute:false)

    en_cours = cadreInfos.where(is_recrute:nil)

    @allCadreNbr = cadreInfos.count

    # nombre
    @c_admisNbr = c_admis.count 
    @c_refuseNbr = c_refuse.count
    @en_coursNbr = en_cours.count
    
    # pourcentage
    @c_admisPercent = ((@c_admisNbr* 100.0)/ @allCadreNbr).round()

    c_refuse_potentialNbr = 0
    c_refuse_fitNbr = 0

    c_refuse.each do |cadre_info|
      case cadre_info.not_admited_test
        when "potential_test"
          c_refuse_potentialNbr += 1
        when "fit_test"
          c_refuse_fitNbr += 1
      end
    end


    @refusePotPercent = ((c_refuse_potentialNbr * 100.0) / @allCadreNbr).round()
    @refuseFitPercent = ((c_refuse_fitNbr * 100.0) / @allCadreNbr).round()
    @en_coursPercent = ((@en_coursNbr * 100.0)/ @allCadreNbr).round()

    # @c_refusePercent = (@c_refuseNbr * 100.0) / @allCadreNbr



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
