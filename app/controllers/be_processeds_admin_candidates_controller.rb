class BeProcessedsAdminCandidatesController < ApplicationAdminController
  before_action :authenticate_admin!
  include GoogleCalendarHelper
  
	def be_processed_inscription
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def be_processed_validate_entretien_fit
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def validate_post_entretien_fit
    require 'googleauth'
    require 'google/apis/calendar_v3'

    @cadreInfo = CadreInfo.find_by_id(params[:cadre_info_id])

    start_time = ""

    unless @cadreInfo.nil?
      if params[:choice] == "accepted"
        @cadreInfo.agenda_admin.update(accepted:true)
        start_time = @cadreInfo.agenda_admin.entretien_date.strftime('%Y-%m-%dT%H:%M:%S')
      elsif params[:choice] == "refused"
        date = params[:date].split("-")
        time = params[:time].split(":")
        day = date[2].to_i
        month = date[1].to_i
        year = date[0].to_i
        hour = time[0].to_i
        min = time[1].to_i
        @cadreInfo.agenda_admin.update(entretien_date:DateTime.new(year,month,day,hour,min).utc,accepted:true)
        start_time = @cadreInfo.agenda_admin.entretien_date.strftime('%Y-%m-%dT%H:%M:%S')
        # message: "L'entretien fit avec #{@cadreInfo.first_name} #{@cadreInfo.last_name} est validé.",
      else
        flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
        redirect_back(fallback_location: root_path)
        return 0
      end

      ProcessedHistory.create(
        image: "/image/profie.png",
        message: "PLANIFICATION ENTRETIEN FIT",
        link: "<a href='#{cbp_validate_entretien_fit_path(@cadreInfo.id)}'>VOIR</a>",
        is_client:false,
        cadre_info:@cadreInfo,
        genre: 1
      )

      summary = "ENTRETIEN FIT"
      location = "Skype"
      description = "Entretien fit validé avec #{@cadreInfo.first_name} #{@cadreInfo.last_name}",
      start_date_time = start_time
      end_date_time = start_time
      time_zone = "UTC",
      attendees_email = []

      GoogleCalendarHelper.insert_event_to_google_calendar(
        summary = summary,
        location = location,
        description = description,
        start_date_time = start_date_time,
        end_date_time = end_date_time,
        time_zone = time_zone,
        attendees_email = attendees_email
      )

      TestOiamMailer.test_fit_validate(@cadreInfo).deliver_now
      flash[:notice] = "Entretien fit validé!"
      redirect_to cbp_validate_entretien_fit_path(@cadreInfo.id)
    else
      flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
      redirect_back(fallback_location: root_path)
      return 0
    end
  end

  def be_processed_efectue_entretien_fit
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def bp_efectue_entretien_fit
    errorMessage = ""
    fileCv = FileUploader.new
    @cadre_infos = CadreInfo.find_by_id(params[:cadre_id])

    if params[:cadre_info].nil?
      errorMessage += " [ Importer le compte rendu ] "
    elsif params[:cadre_info][:compte_rendu].nil?
      errorMessage += " [ Importer le compte rendu ] "
    else
      is_cv = true
      begin
        fileCv.store!(params[:cadre_info][:compte_rendu])
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

    if errorMessage == ""
      
      unless @cadre_infos.nil?
        # ProcessedHistory.create(
        #   image: "/image/profie.png",
        #   # message: "#{@cadre_infos.first_name} #{@cadre_infos.last_name} a terminé l'inscription",
        #   message: "INSCRIPTION",
        #   link: "<a href='#{cbp_inscription_path(@cadre_infos.id)}'>VOIR</a>",
        #   is_client:false,
        #   cadre_info:@cadre_infos,
        #   genre: 1
        # )
        ProcessedHistory.create(
          image: "/image/profie.png",
          # message: "L'entretien fit avec #{@cadre_infos.first_name} #{@cadre_infos.last_name} est traité.",
          message: "ENTRETIEN FIT",
          link: "<a href='#{post_avis_candidats_fit_path(@cadre_infos.id)}'>VOIR</a>",
          cadre_info:@cadre_infos,
          is_client:false,
          genre: 1
        )
      end

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

    else
      flash[:alert] = "#{errorMessage}"
      # redirect_back(fallback_location: root_path)
      redirect_to post_avis_candidats_fit_path(@cadre_infos.id)
    end
  end

  def be_processed_profil_no_complete
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def be_processed_pomise_no_validate
    @cadre_info = CadreInfo.find_by_id(params[:id])
  end

  def be_processed_prime
    @promise = PromiseToHire.find_by_id(params[:id])
    @cadre_info = @promise.cadre.cadre_info
  end

  def post_be_processed_prime

    errorMessage = ""
    @promise = PromiseToHire.find_by_id(params[:promise_to_hire][:promise_id])

    @cadre_info = @promise.cadre.cadre_info

    uploader = ImageUploader.new
    is_error = true
    begin
      uploader.store!(params[:promise_to_hire][:ov_prime])
    rescue StandardError => e
      is_error = false
      errorMessage += " [ #{e.message} ] "
    end

    if is_error
      @promise.ov_prime = uploader.url
      @promise.prime_received = true
      @promise.save
      ProcessedHistory.create(
        image: @cadre_info.image,
        # message: "#{@cadre_info.first_name} #{@cadre_info.last_name} a reçu son prime.",
        message: "PRIME",
        link: "<a href='#{cbp_prime_path(@promise.id)}'>VOIR</a>",
        cadre_info: @cadre_info,
        is_client:false,
        genre: 1
      )
    end

    unless errorMessage.empty?
      flash[:alert] = errorMessage
      redirect_to cbp_prime_path(@promise.id)
    else
      flash[:notice] = "Prime envoyer."
      redirect_to cbp_prime_path(@promise.id)
    end
    
  end

  def show_promise
    @promise = PromiseToHire.find_by_id(params[:id])
    @job = @promise.offre_job
    @cadre = @promise.cadre.cadre_info
  end

end
