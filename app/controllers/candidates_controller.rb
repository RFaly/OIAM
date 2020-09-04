class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, except: [:postMetierSkills,:main,:my_tests,:testpotential,:testskills,:testfit,:saveEntretientDate,:resultatsTest,:tmp_sign_up,:tmp_create_sign_up]
  before_action :validate_cadre, only: [:my_tests, :testpotential, :testskills, :testfit, :resultatsTest, :postMetierSkills]
  before_action :current_info_cadre, only: [:my_profil, :edit_profil, :confirmedProfil]

  def main
  end

  def tmp_sign_up
    unless cookies.encrypted[:oiam_cadre].nil?
      # @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
      flash[:notice] = "Vous pouvez continuer votre test."
      redirect_to my_tests_path
    end
    @cadreInfo = CadreInfo.new
  end

  def tmp_create_sign_up
    @cadreInfo = CadreInfo.new(post_params_tmp)
    if @cadreInfo.save
      cookies.encrypted[:oiam_cadre] = {
        value: @cadreInfo.id,
        expires: Time.now + 172800
      }
      redirect_to my_tests_path
    else
      render :tmp_sign_up
    end
  end

  def my_profil
    validate_info_cadre
  end

  def validate_profil
    current_cadre.cadre_info.update(is_validate:true)
  end

  def main_test
    validate_info_cadre
  end

  def edit_profil
  end

  def confirmedProfil
    errorMessage = ""

    is_error = params[:cadre_info][:question1].empty? || params[:cadre_info][:question3].empty? || params[:cadre_info][:question4].empty? || params[:cadre_info][:question5].empty? || params[:cadre_info][:status].empty? || params[:cadre_info][:disponibilite].empty? || params[:cadre_info][:mobilite].empty?
    if is_error
      errorMessage += " [ Tous les champs sont obligatoire ] "
    end

    fileCv = FileUploader.new
    if params[:cadre_info][:cv].nil? && @cadre.cv.nil?
      errorMessage += " [ Importer votre CV ] "
    elsif !params[:cadre_info][:cv].nil?
      is_cv = true
      begin
        fileCv.store!(params[:cadre_info][:cv])
      rescue StandardError => e
        is_cv = false
        errorMessage += " [ CV: #{e.message} ] "
      end
      if is_cv
        @cadre.cv = fileCv.url
      end
    end

    uploader = ImageUploader.new
    if params[:cadre_info][:image].nil? && @cadre.image.nil?
      errorMessage += " [ Importer votre photo de profil ] "
    elsif !params[:cadre_info][:image].nil?
      is_img = true
      begin
        uploader.store!(params[:cadre_info][:image])
      rescue StandardError => e
        is_img = false
        errorMessage += " [ Photo: #{e.message} ] "
      end
      if is_img
        @cadre.image = uploader.url
      end
    end

    if errorMessage.empty?
      if params[:cadre_info][:deplacement] == "1"
        @cadre.frequency = params[:cadre_info][:frequency]
        @cadre.deplacement = true
      else
        @cadre.deplacement = false
      end

      c = Country.find_by(name:params[:cadre_info][:country])
      r = Region.find_by(name:params[:cadre_info][:region])
      v = Ville.find_by(name:params[:cadre_info][:ville])

      @cadre.country = c
      @cadre.region = r
      @cadre.ville = v

      @cadre.save

      @cadre.update(post_params)
      @cadre.update(empty:false)
      redirect_to my_profil_path
    else
      flash[:alert] = "#{errorMessage}"
      render :edit_profil
      return
    end

  end

	def searchJob
    validate_info_cadre
    @metiers = Metier.all
    @offres = OffreJob.where(is_publish:true)
	end

  def jobsPersonalized
    validate_info_cadre

  end

  def showSearchJob
    @offre = OffreJob.find_by_id(params[:id])
    if @offre.nil?
      flash[:alert] = "Cette offre n'est plus disponible."
      redirect_back(fallback_location: root_path)
    elsif @offre.is_publish == false
      flash[:alert] = "Cette offre n'est plus disponible."
      redirect_back(fallback_location: root_path)
    end
    @ofc = @offre.is_in_this_job(current_cadre)
    @agendat_client = @offre.in_list_entretien(current_cadre)
  end

	def favoriteJob
    validate_info_cadre
    @offres = OffreJob.joins(:favorite_jobs).where(favorite_jobs:{cadre_id:current_cadre.id})
	end

  def addToFavoriteJob
    @offre = OffreJob.find_by_id(params[:id])
    @favoriteJob = FavoriteJob.find_by(offre_job: @offre, cadre: current_cadre)
    if @offre.nil?
      redirect_to wellcome_path
    else
      if @favoriteJob.nil?
        @favoriteJob = FavoriteJob.create(offre_job: @offre, cadre: current_cadre)
      end
      respond_to do |format|
        format.html do
          redirect_to searchJob_path
        end
        format.js do

        end
      end
    end
  end

  def removeToFavoriteJob
    @offre = OffreJob.find_by_id(params[:id])
    if @offre.nil?
      redirect_to welcome_path
    else
      @favoriteJob = FavoriteJob.find_by(offre_job: @offre, cadre: current_cadre)
      unless @favoriteJob.nil?
        @favoriteJob.destroy
      end
      respond_to do |format|
        format.html do
          redirect_to searchJob_path
        end
        format.js do

        end
      end
    end
  end

  def apply_for_job
    offre = OffreJob.find_by_id(params[:id])
    if offre.nil?
      redirect_back(fallback_location: root_path)
    else
      offre_for_candidate = OffreForCandidate.find_by(offre_job:offre,cadre:current_cadre)
      if offre_for_candidate.nil?
        OffreForCandidate.create(offre_job:offre,cadre:current_cadre)
      end
    end
  end

#mes offre réçues
  def received_job
    @oFcs = OffreForCandidate.where(cadre:current_cadre,accepted_postule:true)
    @agendaClients = []
    @oFcs.each do |oFc|
      agendaItems = {}
      agendaItems[:agenda_client] = oFc.agenda_clients.where(repons_client: true, repons_cadre: nil, alternative: nil).order('created_at DESC')[0]
      unless agendaItems[:agenda_client].nil?
        agendaItems[:intitule_pote] = oFc.offre_job.intitule_pote
        agendaItems[:offre_id] = oFc.offre_job.id
        agendaItems[:image] = oFc.offre_job.image
        @agendaClients.push(agendaItems)
      end
    end
  end

  def post_repons_received_job
    @offreJob = OffreJob.find_by_id(params[:offre_id])
    @agendaClient = AgendaClient.find_by_id(params[:agenda_id])
    @oFc = OffreForCandidate.find_by(offre_job: @offreJob, cadre: current_cadre)
    case params[:reponse]
    when "0"
      @agendaClient.update(alternative:params[:alternative],repons_cadre: false)
      flash[:notice] = "Votre réponse est envoyé avec succes."
      redirect_to show_recrutment_monitoring_path(@oFc.id)
    when "1"
      @agendaClient.update(repons_cadre:true)
      flash[:notice] = "Votre réponse est envoyé avec succes."
      redirect_to show_recrutment_monitoring_path(@oFc.id)
    when "2"
      date = params[:date].split("-")
      time = params[:time].split(":")
      year = date[0].to_i
      month = date[1].to_i
      day = date[2].to_i
      hour = time[0].to_i
      min = time[1].to_i
      date_time = DateTime.new(year,month,day,hour,min).utc
      @agendaClient.update(alternative: date_time.to_s, repons_cadre:true)
      flash[:notice] = "Votre réponse est envoyé avec succes."
      redirect_to show_recrutment_monitoring_path(@oFc.id)
    else
      flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
      redirect_to root_path
    end
  end

	def recrutmentMonitoring
    validate_info_cadre
    tmp_oFcs = OffreForCandidate.where(cadre: current_cadre)
    @oFcs = []
    tmp_oFcs.each do |oFc|
      next if oFc.accepted_postule == true && oFc.repons_postule.nil? && oFc.agenda_clients.empty?
      @oFcs.push(oFc)
    end
	end

  def showRecrutmentMonitoring
    @oFc = OffreForCandidate.find_by_id(params[:ofc_id])
    
    if @oFc.nil?
      redirect_back(fallback_location: root_path)
      return
    end

    unless @oFc.cadre == current_cadre
      redirect_back(fallback_location: root_path)
      return
    end
    
    @offreJob = @oFc.offre_job
    @cadre = current_cadre
    @agendas = @oFc.agenda_clients.order('created_at DESC')[0]
    @promise = @offreJob.promise_to_hires.find_by(cadre:@cadre)

  end

  def notifications

  end

# 3 test de recrutement

  def my_tests
  end

  def testpotential
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
  end

  def testskills
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
  end

  def postMetierSkills
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
    @metier = Metier.find_by_id(params[:cadre_info][:metier_id])
    @cadreInfo.update(metier:@metier)
  end

  def testfit
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
    @agendaAdmin = @cadreInfo.agenda_admin
    if @agendaAdmin.nil?
      date = @cadreInfo.created_at.to_datetime
      @dates = []
      @datesShorts = []
      i = 1
      while @dates.length < 2
        tmp_date = date.next_day(i)
        if !tmp_date.saturday?
          if !tmp_date.sunday?
            long_date = l tmp_date, :format => :long
            @dates.push({long:long_date[0 .. -7],short:"#{tmp_date.day}-#{tmp_date.month}-#{tmp_date.year}"})
          end
        end
        i += 1
      end
    else
      @dates = l @agendaAdmin.entretien_date, :format => :long
    end
  end

  def saveEntretientDate
    date = params[:date].split("-")
    time = params[:time].split(":")
    day = date[0].to_i
    month = date[1].to_i
    year = date[2].to_i
    hour = time[0].to_i
    min = time[1].to_i
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
    @agenda = AgendaAdmin.new(entretien_date:DateTime.new(year,month,day,hour,min).utc,cadre_info:@cadreInfo)
    if @agenda.save
      puts "vô sôvy e"
    else
      puts "tsy vô sovy e"
      flash[:alert] = @agenda.errors.details
    end
  end

# Resultat test
  def resultatsTest
    @cadreInfo = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
  end

#~~~~~~~~~~ Message ~~~~~~~~~~~~~~~~~~~~
  def my_messages
    @clients = Client.all
    @contactListes = current_cadre.contact_client_cadres
  end

  def show_my_messages
    @client = Client.find_by_id(params[:id])
    @contact = ContactClientCadre.where(client: @client, cadre:current_cadre)
    if @contact.count == 0
      @contact = ContactClientCadre.create(client: @client, cadre:current_cadre)
    else
      @contact = @contact.first
    end
    #marquer tous comme lue
    @contact.message_client_cadres.where(cadre_see:false).update(cadre_see:true)
    @messages = @contact.message_client_cadres.order(created_at: :ASC)
    @newMessage = MessageClientCadre.new
  end

  def post_my_message
    @client = Client.find_by_id(params[:message_client_cadre][:client_id])
    @contact = ContactClientCadre.find_by_id(params[:message_client_cadre][:contact_id])
    @content = params[:message_client_cadre][:content]
    @newMessage = MessageClientCadre.new(content:@content, cadre_see: true,contact_client_cadre: @contact,is_client:false)

    respond_to do |format|
      format.html do
        if @newMessage.save
          @contact.message_client_cadres.update(cadre_see:true)
          redirect_to zshowMessages_path(@client.id)
        else
          flash[:alert] = @newMessage.errors.details
          redirect_to zshowMessages_path(@client.id)
        end
      end
      format.js do
        if @newMessage.save
          @contact.message_client_cadres.update(cadre_see:true)
          @errors = false
        else
          flash[:alert] = @newMessage.errors.details
          redirect_to zshowMessages_path(@client.id)
        end
      end
    end
  end

  def getLastMessage
    @client = Client.find_by_id(params[:client_id])
    @contact = ContactClientCadre.find_by_id(params[:contact_id])
    if @contact.nil?
      @messages = []
    else
      if @contact.client == @client && @contact.cadre == current_cadre
        @messages = @contact.message_client_cadres.order(created_at: :ASC).last(50)
      else
        @messages = []
      end
    end
  end

  def cadre_show_promise_to_hire
    @promise = PromiseToHire.find_by_id(params[:id])
    @cadre = current_cadre.cadre_info
    @job = @promise.offre_job
    @current_client = @job.client
  end

  def cadre_update_promise_to_hire
    @promise = PromiseToHire.find_by_id(params[:id_pdm])
    errorMessage = ""

    sinc = params[:promise_to_hire][:signature_candidat]
    cin = params[:promise_to_hire][:cin_pass_port]
    s_c = params[:promise_to_hire][:security_certificate]
    rib = params[:promise_to_hire][:rib]

    if validate_nil?(params[:promise_to_hire][:birthday_cadre]) || validate_nil?(params[:promise_to_hire][:birthplace_cadre]) || validate_nil?(params[:promise_to_hire][:ns_sociale_cadre])
      flash[:alert] = "Tous les champs sont obligatoires."
      redirect_back(fallback_location: root_path)
      return
    end

    if sinc.nil? || cin.nil? || s_c.nil? || rib.nil?
      flash[:alert] = "Importer tous les fichiers demandés."
      redirect_back(fallback_location: root_path)
      return
    end

    file_sinc = ImageUploader.new
    begin
      file_sinc.store!(sinc)
    rescue StandardError => e
      errorMessage += " [ Signature Candidate: #{e.message} ] "
    end
    file_cin = AllUploader.new
    begin
      file_cin.store!(cin)
    rescue StandardError => e
      errorMessage += " [ CIN ou Passeport: #{e.message} ] "
    end
    file_sc = AllUploader.new
    begin
      file_sc.store!(s_c)
    rescue StandardError => e
      errorMessage += " [ Attestation de sécurité sociale: #{e.message} ] "
    end
    filerib = AllUploader.new
    begin
      filerib.store!(rib)
    rescue StandardError => e
      errorMessage += " [ RIB: #{e.message} ] "
    end

    if errorMessage.empty?
      @promise.update(birthday_cadre: params[:promise_to_hire][:birthday_cadre], birthplace_cadre: params[:promise_to_hire][:birthplace_cadre], ns_sociale_cadre: params[:promise_to_hire][:ns_sociale_cadre], signature_candidat: file_sinc.url, cin_pass_port: file_cin.url, security_certificate: file_sc.url, rib: filerib.url, repons_cadre:true)
      @offreJob = @promise.offre_job
      @offreJob.next_stape
      Facture.create(prix:(@offreJob.remuneration * 1000 * 15)/100,promise_to_hire:@promise,client:@promise.offre_job.client)
      #créé un cacture rib:"/image/OIAM_DIAMOND.png",
      redirect_to congratulations_cadre_path(@promise.id)
    else
      flash[:alert] = errorMessage
      redirect_back(fallback_location: root_path)
    end

  end

  def congratulations_cadre
    @promise = PromiseToHire.find_by_id(params[:id])
    if @promise.nil?
      flash[:alert] = "Page introuvable"
      redirect_back(fallback_location: root_path)
    else
      unless @promise.repons_cadre
        flash[:alert] = "Page introuvable"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def save_coordinate_banking #formularie pour enregistrer la coordonné bancaire
    # gem wiked_pdf
  end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  private

  def validate_cadre
    unless current_cadre
      if cookies.encrypted[:oiam_cadre].nil?
        flash[:alert] = "Vous devez vous inscrire pour effectuer les tests."
        redirect_to tmp_sign_up_path
      else
        @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
        if @cadre.nil?
          cookies.delete :oiam_cadre
          flash[:alert] = "Vous devez vous inscrire pour effectuer les tests."
          redirect_to tmp_sign_up_path
        end
      end
    end
  end

  def post_params_tmp
    params.require(:cadre_info).permit(:last_name,:first_name,:adresse,:postal_code,:city,:telephone,:mail)
  end

  def post_params
    params.require(:cadre_info).permit(:question1,:question3,:question4,:question5,:status,:disponibilite,:mobilite)
  end

  def current_info_cadre
    @cadre = current_cadre.cadre_info
  end

  def validate_info_cadre
    if current_cadre.cadre_info.empty
      flash[:notice] = "Veuillez compléter votre profil."
      redirect_to edit_profil_path
    end
  end

  def validate_nil?(date_value)
    unless date_value.nil?
      if date_value.empty?
        return true
      end
      return false
    else
      return true
    end
  end

end
