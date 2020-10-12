class AdminCadreController < ApplicationAdminController
  before_action :authenticate_admin!

  #tous les candidats
  def all_cadre
  end

  #cadre non admis
  def cadre_not_admitted
  end

  #cadre admis
  def cadre_admitted
    
  end

  # entretien fit
  def entretien_fit
    @cadres = current_admin.cadre_infos
    # @cadres = CadreInfo.where(cadre_id:nil,is_recrute:nil,score_fit:nil)
  end








  def send_message
  end

  
  def show_accepted_cadre
    helpers.updateNotification(params[:secure])
    @cadre = CadreInfo.find_by(id:params[:id])
  end

  def accepted_or_reffused
    @cadre = CadreInfo.find_by(id:params[:id])
    @cadre.agenda_admin.update(accepted:true)
    redirect_to post_avis_candidats_fit_path(@cadre.id)
  end

  def candidate_to_cadre
    errorMessage = ""
    fileCv = FileUploader.new
    @cadre_infos = CadreInfo.find_by_id(params[:cadre_id])
    if params[:cadre][:compte_rendu].nil?
      errorMessage += " [ Importer le compte rendu ] "
    else
      is_cv = true
      begin
        fileCv.store!(params[:cadre][:compte_rendu])
      rescue StandardError => e
        is_cv = false
        errorMessage += " [ Compte rendu : #{e.message} ] "
      end
      if is_cv
        @cadre_infos.compte_rendu = fileCv.url
      end
    end
    @cadre_infos.avis = params[:avis]
    @cadre_infos.score_fit = params[:score_fit].to_i
    if params[:is_recrute].nil?
      flash[:notice] = "Candidature refusée."
      TestOiamMailer.test_fit_refused(@cadre_infos).deliver_now
      @cadre_infos.is_recrute = false
    else
      flash[:notice] = "Candidature acceptée."
      TestOiamMailer.test_fit_accepted(@cadre_infos).deliver_now
      @cadre_infos.is_recrute = true
    end
    @cadre_infos.save
    redirect_to post_avis_candidats_fit_path(@cadre_infos.id)
  end

  def show_refused_cadre

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

  def show_profile
    puts "~~"*43
    puts params[:id]
    puts "~~"*43
  end
end
