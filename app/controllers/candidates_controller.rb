class CandidatesController < ApplicationController
  #def pas besoin de connexion
  before_action :authenticate_cadre!, except: [:save_scores_potential_test,:getScoresPotential,:postMetierSkills,:main,:my_tests,:testpotential,:init_testpotential,:testskills,:testfit,:saveEntretientDate,:resultatsTest,:tmp_sign_up,:tmp_create_sign_up,:save_repons_test_potential]
  # def valider si tmp signup ok
  before_action :validate_cadre, only: [:getScoresPotential,:init_testpotential, :my_tests, :testpotential, :testskills, :testfit, :resultatsTest, :postMetierSkills]
  # if empty info cadre, remplir profil
  before_action :current_info_cadre, only: [:my_profil, :edit_profil, :confirmedProfil]

  protect_from_forgery except: :save_repons_test_potential

  def main
  end

  def my_profil
    validate_info_cadre
  end

  def validate_profil
    current_cadre.cadre_info.update(is_validate:true)
  end

  def main_test
    validate_info_cadre
    @cadre = current_cadre.cadre_info
  end

  def edit_profil
    @meties = Metier.all
  end

  def confirmedProfil
    errorMessage = ""

    is_error = params[:cadre_info][:job].empty? || params[:cadre_info][:question3].empty? || params[:cadre_info][:question4].empty? || params[:cadre_info][:question5].empty? || params[:cadre_info][:status].empty? || params[:cadre_info][:disponibilite].empty? || params[:cadre_info][:mobilite].empty?
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

      metier = Metier.find_by_id(params[:cadre_info][:metier_id])
      c = Country.find_by(name:params[:cadre_info][:country])
      r = Region.find_by(name:params[:cadre_info][:region])
      v = Ville.find_by(name:params[:cadre_info][:ville])

      @cadre.metier = metier
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
    @regions = Region.all
    @offres = OffreJob.where(is_publish:true)
	end

  def jobsPersonalized
    validate_info_cadre
    cadre_info = current_cadre.cadre_info
    minimum_salar = cadre_info.question4.to_i
    region = cadre_info.region.name
    ville = cadre_info.ville.name
    @offres = cadre_info.metier.offre_jobs
    @offres = @offres.where("remuneration >= #{minimum_salar}")
    @offres = @offres.where(type_deplacement: cadre_info.mobilite)
    unless region == "Toutes les régions"
      if ville == "Tous les départements"
        @offres = @offres.where(region:region)
      else
        @offres = @offres.where(region:region,department:ville)
      end
    end
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
        first_name = current_cadre.cadre_info.first_name
        last_name = current_cadre.cadre_info.last_name
        OffreForCandidate.create(offre_job:offre,cadre:current_cadre)
        #notifaka
        Notification.create(client:offre.client,object: "#{first_name} #{last_name}", message: "#{first_name} #{last_name[0].upcase}. a postulé sur le poste : #{offre.intitule_pote}.", link: "#{show_search_candidate_path(current_cadre.id, offre_id: offre.id)}", genre: 3, medel_id: current_cadre.id, view: false)
      end
    end
  end

#mes offre réçues
  def received_job
    helpers.updateNotification(params[:secure])
    @oFcs = OffreForCandidate.where(cadre:current_cadre,accepted_postule:true)
    @agendaClients = []
    @oFcs.each do |oFc|
      current_agenda = oFc.agenda_clients.where(repons_client: true, repons_cadre: nil, alternative: nil).order('created_at DESC')[0]
      agendaItems = {}
      unless current_agenda.nil?
        next if current_agenda.entretien_date < DateTime.now.utc
        agendaItems[:agenda_client] = current_agenda
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

    first_name = current_cadre.cadre_info.first_name
    last_name = current_cadre.cadre_info.last_name

    case params[:reponse]
    when "0"
      @agendaClient.update(alternative:params[:alternative],repons_cadre: false,notifed:false)
      #notifaka
      Notification.create(client: @offreJob.client,object: "#{first_name} #{last_name}",message: "#{first_name} #{last_name[0].upcase}. a refusé votre demande d'entretien.",link: "#{recruitment_show_cadre_path(@oFc.id,notification:"entretien")}",genre: 1,medel_id: current_cadre.id,view: false)

      flash[:notice] = "Votre réponse est envoyé avec succes."
      redirect_to show_recrutment_monitoring_path(@oFc.id)
    when "1"
      @agendaClient.update(repons_cadre:true,notifed:false)
      #notifaka
      Notification.create(client: @offreJob.client,object: "#{first_name} #{last_name}",message: "#{first_name} #{last_name[0].upcase}. a accepté votre demande d'entretien.",link: "#{recruitment_show_cadre_path(@oFc.id,notification:"entretien")}",genre: 1,medel_id: current_cadre.id,view: false)

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
      @agendaClient.update(alternative: date_time.to_s, repons_cadre:true,notifed:false)
      flash[:notice] = "Votre réponse est envoyé avec succes."

      #notifaka
      Notification.create(client: @offreJob.client,object: "#{first_name} #{last_name}",message: "#{first_name} #{last_name[0].upcase}. a proposé une autre date pour l'entretien.",link: "#{recruitment_show_cadre_path(@oFc.id,notification:"entretien")}",genre: 1,medel_id: current_cadre.id,view: false)

      redirect_to show_recrutment_monitoring_path(@oFc.id)
    else
      flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
      redirect_to root_path
    end
  end

	def recrutmentMonitoring
    validate_info_cadre
    tmp_oFcs = OffreForCandidate.where(cadre: current_cadre).order("created_at DESC")
    @oFcs = []
    tmp_oFcs.each do |oFc|
      next if ((oFc.accepted_postule.nil? || oFc.accepted_postule == true) && oFc.repons_postule.nil? && oFc.agenda_clients.empty?)
      @oFcs.push(oFc)
    end
	end

  def showRecrutmentMonitoring
    helpers.updateNotification(params[:secure])
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
    # @promise = @offreJob.promise_to_hires.find_by(cadre:@cadre)
    @promise = @offreJob.promise_to_hires.joins(:cadre).find_by(cadre:current_cadre)

  end

  def notifications
    @notifications = current_cadre.notifications.order("created_at DESC")
  end

#BEGIN -----------------------------------------------------------------
# inscription candidate pour les tests
  def tmp_sign_up
    unless cookies.encrypted[:oiam_cadre].nil?
      @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
      flash[:notice] = "Vous pouvez continuer votre test."
      redirect_to my_tests_path
    end
    @cadreInfo = CadreInfo.new
  end

  def tmp_create_sign_up
    @cadreInfo = CadreInfo.new(post_params_tmp)
    if @cadreInfo.save
      cookies.encrypted[:oiam_cadre] = {
        value: @cadreInfo.confirm_token,
        expires: Time.now + 172800
      }
      redirect_to my_tests_path
    else
      render :tmp_sign_up
    end
  end

# 3 test de recrutement
  def my_tests
  end

  def testpotential
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
    if @cadreInfo.potential_test
      flash[:notice] = "Vous pouvez continuer votre test."
      redirect_to resultatsTest_path
    end
  end

  def init_testpotential
    @header = true
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
    if @cadreInfo.potential_test
      flash[:notice] = "Vous pouvez continuer votre test."
      redirect_to resultatsTest_path
    end
  end

  # api api
  def save_repons_test_potential #call in api
    # http://fc16455.online-server.cloud/cadre/repons-test-potential
    @cadreInfo = CadreInfo.find_by(mail:params[:custom_fields][3]["value"])
    # @cadreInfo.update(score_potential:1005,potential_test:true)
    @cadreInfo.update(potential_test:true)
  end

# recupere le score
  def save_scores_potential_test
    @cadreInfo = CadreInfo.find_by(mail:params[:email])
    if @cadreInfo.nil?
      flash[:alert] = "Aucun candidat inscrit avec cet email."
    else
      is_recrute = false
      if params[:score].to_i >= CadreInfo.min_score
        is_recrute = nil
      end
      @cadreInfo.update(is_recrute:is_recrute,potential_test:true,score_potential:params[:score].to_i)

      #notifaka

      NotificationAdmin.create(
        object: "Nouveau candidat: #{@cadreInfo.first_name} #{@cadreInfo.last_name}",
        message: "#{@cadreInfo.first_name} #{@cadreInfo.last_name[0].upcase}. viens de finir le test potentiel.",
        link: "/",
        genre: 2)


      flash[:notice] = "#{@cadreInfo.first_name} #{@cadreInfo.last_name} a été notifié par email du résultat du test !"
    end
    redirect_to nothing_path
  end

#~~~~~~~~~~~ not add to app
  def testskills
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
    unless @cadreInfo.is_recrute
      redirect_to resultatsTest_path
    end
  end

  def postMetierSkills
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
    @metier = Metier.find_by_id(params[:cadre_info][:metier_id])
    @cadreInfo.update(metier:@metier)
  end
#~~~~~~~~~~~ not add to app

  # Resultat test
  def resultatsTest
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
    if @cadreInfo.nil?
      redirect_back(fallback_location: root_path)
    else
      unless @cadreInfo.potential_test
        flash[:notice] = "En attente du résultat de votre test potentiel."
        @cadreInfo.update(potential_test:true)
      end
    end
  end

  def getScoresPotential
    @cadreInfo = CadreInfo.find_by_confirm_token(params[:confirm_token])
  end

  def testfit
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])

    @agendaAdmin = @cadreInfo.agenda_admin
    if @agendaAdmin.nil?
      date = @cadreInfo.created_at.to_datetime.utc
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
    @cadreInfo = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])

    date = params[:date].split("-")
    time = params[:time].split(":")
    day = date[0].to_i
    month = date[1].to_i
    year = date[2].to_i
    hour = time[0].to_i
    min = time[1].to_i

    @agenda = AgendaAdmin.new(entretien_date:DateTime.new(year,month,day,hour,min).utc,cadre_info:@cadreInfo)

    if @agenda.save
      @cadreInfo.update(fit_test:true)
    else
      flash[:alert] = @agenda.errors.details
    end

  end

#maketo
  def createScorePototial
    puts "--"*32
    puts params.inspect
    puts "--"*32
  end

#END ---------------------------------------------------------------------


#~~~~~~~~~~ Message ~~~~~~~~~~~~~~~~~~~~
  def my_messages
    @clients = Client.all
    @contactListes = current_cadre.contact_client_cadres
    @contact = ContactClientCadre.where(cadre: @cadre, client:current_client)
    if @contact.count == 0
      @contact = ContactClientCadre.create(cadre: @cadre, client:current_client)
    else
      @contact = @contact.first
    end
    @contact.message_client_cadres.where(client_see:false).update(client_see:true)
    @messages = @contact.message_client_cadres.order(created_at: :ASC)
  end

  def show_my_messages
    @client = Client.find_by_id(params[:id])
    @img = @client.image
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
    respond_to do |format|
  		format.html { }
  		format.js { }
  	end
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
    helpers.updateNotification(params[:secure])
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

      # calcul prix honoraire oiam
      prix = ((@promise.remuneration_fixe_date.to_i * @promise.remuneration_fixe.to_f.round(2))) * 10 * 20
      pcalcul = (prix/1000).round(2)
      facture = Facture.create(prix: pcalcul,promise_to_hire:@promise,client:@promise.offre_job.client)

      #créé un cacture rib:"/image/OIAM_DIAMOND.png",

      oFc = @offreJob.my_top_five_candidates.find_by(cadre:current_cadre)
      first_name = current_cadre.cadre_info.first_name
      last_name = current_cadre.cadre_info.last_name
      # notifaka eto
      Notification.create(client: @offreJob.client,object: "#{first_name} #{last_name}",message: "#{first_name} #{last_name[0].upcase}. vient d'accepter votre proposition d'embauche !",link: "#{recruitment_show_cadre_path(oFc.id,notification:"entretien")}",genre: 1,medel_id: current_cadre.id,view: false)

      oFc = @offreJob.is_in_this_job(current_cadre)

      redirect_to show_recrutment_monitoring_path(oFc.id)
    else
      flash[:alert] = errorMessage
      redirect_back(fallback_location: root_path)
    end

  end

  def validate_time_trying_cadre
    @promise = PromiseToHire.find_by_confirm_token(params[:confirm_token])
    @offreJob = @promise.offre_job
    oFc = @offreJob.is_in_this_job(current_cadre)
    @promise.update(cadre_time_trying:true)

    first_name = current_cadre.cadre_info.first_name
    last_name = current_cadre.cadre_info.last_name
    flash[:notice] = "Période d'essai bien validé."
    #notifaka
    Notification.create(client: @offreJob.client,object: "#{first_name} #{last_name}",message: "#{first_name} #{last_name[0].upcase}. a validé sa période d'essai.",link: "#{recruitment_show_cadre_path(oFc.id,notification:"validation")}",genre: 1,medel_id: current_cadre.id,view: false)

    redirect_to show_recrutment_monitoring_path(oFc.id)
  end

  def congratulations_cadre
    @header = true #not show a nav_bar for madal page
    @promise = PromiseToHire.find_by_confirm_token(params[:confirm_token])
    if @promise.nil?
      flash[:alert] = "Page introuvable"
      redirect_back(fallback_location: root_path)
    else
      unless @promise.repons_cadre
        flash[:alert] = "Page introuvable"
        redirect_back(fallback_location: root_path)
      else
        @promise.update(ask_salar:true)
        #notifaka admin
      end
    end
  end

  def save_coordinate_banking #formularie pour enregistrer la coordonné bancaire
    # gem wiked_pdf
  end

  def search_bar_job

    @offres = OffreJob.where(is_publish:true)

    region = params[:region]

    unless region.empty?
      unless region == "all"
        region = Region.find_by_id(region)
        @offres = @offres.where(region: region.name)
      end
    end

    unless params[:metier].empty?
      metier = Metier.find_by_id(params[:metier])
      unless metier.nil?
        @offres = @offres.where(metier: metier)
      end
    end

    unless params[:remuneration].empty?
      @offres = @offres.where("remuneration >= #{params[:remuneration].to_i}")
    end

    unless params[:deplacement].empty?
      @offres = @offres.where(type_deplacement:params[:deplacement])
    end

    if params[:region].empty? && params[:metier].empty? && params[:remuneration].empty? && params[:deplacement].empty?
      @offres = []
    end

    respond_to do |format|
      format.html do
        redirect_to searchJob_path
      end
      format.js do
      end
    end

  end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  private

  def validate_cadre
    unless current_cadre
      if cookies.encrypted[:oiam_cadre].nil?
        flash[:alert] = "Vous devez vous inscrire pour effectuer les tests."
        redirect_to tmp_sign_up_path
      else
        @cadre = CadreInfo.find_by_confirm_token(cookies.encrypted[:oiam_cadre])
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
    params.require(:cadre_info).permit(:job,:question3,:question4,:question5,:status,:disponibilite,:mobilite)
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
