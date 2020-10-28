class BeProcessedsAdminCandidatesController < ApplicationController
	def be_processed_inscription
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def be_processed_validate_entretien_fit
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def be_processed_efectue_entretien_fit
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def bp_efectue_entretien_fit
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

  def be_processed_profil_no_complete
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

end
