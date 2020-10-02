class RecruteursController < ApplicationController
	before_action :authenticate_client!, except: :main

  def main
  end

	#Mon profil
  def my_profil
  	@client = current_client
  	@entreprise = @client.entreprise
  end

  def my_profil_edit
  	@client = current_client
		@entreprise = @client.entreprise
  end

  def update_my_profil
  	errorMessage = ""
  	uploader = ImageUploader.new
  	@client = current_client
		@entreprise = @client.entreprise
		@client.update(params.require(:client).permit(:first_name,:last_name,:fonction,:mail,:telephone))
		@entreprise.update(name: params[:entreprise_name],adresse: params[:entreprise_adresse],siret: params[:entreprise_siret],city: params[:city],postal_code: params[:postal_code],code_naf: params[:code_naf],site: params[:entreprise_site],description: params[:entreprise_description])

    if params[:client][:image].nil? && current_client.image.nil?
    	errorMessage += " [ Ajouter une photo de profil ] "
    elsif !params[:client][:image].nil?
    	is_cv = true
      begin
        uploader.store!(params[:client][:image])
      rescue StandardError => e
        is_cv = false
        errorMessage += " [ #{e.message} ] "
      end
      if is_cv
        @client.image = uploader.url
    		@client.save
      end
    end

		unless errorMessage.empty?
			flash[:alert] = errorMessage
			return render :my_profil_edit
		else
			flash[:notice] = "Vos modifications ont bien été sauvegardées."
			redirect_to client_my_profil_path
		end
  end

#Mes offres d’emploi
	def my_job_offers
		@offres = current_client.offre_jobs
	end

	def newJob
		@offre = OffreJob.new
		@metiers = Metier.all
	end

##validation
	def createJob
		
		@offre = OffreJob.new(post_params)
		@metier = Metier.find_by_name(params[:metier_name])

		@offre.metier = @metier
		@offre.client = current_client

		uploader = ImageUploader.new
		errorMessage = ""
		image_entreprise = params[:offre_job][:image]
		is_image = true

		unless image_entreprise.nil?
	    begin
	      uploader.store!(image_entreprise)
	    rescue StandardError => e
	      is_image = false
	      errorMessage += " [ #{e.message} ] "
	    end
		else
			errorMessage += " [ Importer un logo ] "
			return render :newJob
		end

		if is_image && @offre.valid? && errorMessage.empty?
    	@offre.image = uploader.url
    	@offre.save
      redirect_to showNewJob_path(@offre)
    else
			@offre.errors.details[:logo] = errorMessage
    	flash[:alert] = @offre.errors.details
    	return render :newJob
		end

	end

	def editJob
		@offre = OffreJob.find(params[:id])
		@metiers = Metier.all
	end

	def updateJob
		uploader = ImageUploader.new
		@offre = OffreJob.find(params[:id])
		image_entreprise = params[:offre_job][:image]
		unless image_entreprise.nil?
			begin
				uploader.store!(image_entreprise)
			rescue StandardError => e
				flash[:alert] = " [ #{e.message} ] "
				return render :editJob
			end
		end
		unless image_entreprise.nil?
			@offre.update(image:uploader.url)
		end

		@metier = Metier.find_by_name(params[:metier_name])
	
		@offre.update(metier:@metier)
		@offre.update(post_params)
		flash[:notice] = "Votre offre d'emploi a bien été mise à jour !"
		redirect_to showNewJob_path(@offre)
	end
	
	def showNewJob
		@offre = OffreJob.find_by_id(params[:id])
		if @offre.client != current_client
			flash[:alert] = "Cette offre n'est plus disponible."
			redirect_back(fallback_location: root_path)
		end
	end

	def publish
		@offre = OffreJob.find(params[:id])
		@offre.update(is_publish:true)
		if @offre.etapes == 0
			@offre.next_stape
		end
	end

	def destroyJob
		@offre = OffreJob.find(params[:id])
		@offre.destroy
		respond_to do |format|
			format.html { redirect_to :my_job_offers }
			format.js { }
		end
	end

	def our_selection
		@offre = OffreJob.find_by_id(params[:id])
		@cadre_infos = @offre.metier.cadre_infos.where(empty:false)

    region = Region.find_by_name(@offre.region)
    ville = region.villes.find_by_name(@offre.department)

    minimum_salar = @offre.remuneration.to_i

    @cadre_infos = @cadre_infos.where("question4 <= #{minimum_salar}")

    @cadre_infos = @cadre_infos.where(mobilite: @offre.type_deplacement)

    my_cadres = []

    unless @cadre_infos.empty?
    	@cadre_infos.each do |cadre_info|
    		if cadre_info.region.name = "Toutes les régions"
    			my_cadres.push(cadre_info)
    		else
    			if ville.name == "Tous les départements"
						if cadre_info.region == region
							my_cadres.push(cadre_info)
						end
					else
						if cadre_info.region == region && cadre_info.ville == ville
							my_cadres.push(cadre_info)
						end
					end
    		end
    	end
    end
    @cadre_infos = my_cadres

	end

	def search_candidate
		@offre = OffreJob.find_by_id(params[:id])
		@topCinqs = @offre.my_top_five_candidates
		@metiers = Metier.all
    @regions = Region.all
		#afficher tous les cadre dans la bdd
		@cadres = Cadre.joins(:cadre_info).where("cadre_infos.empty = ?",false)
	end

	def search_bar_cadre
		# @cadres
		@offre = OffreJob.find_by_id(params[:id])
		@cadre_infos = CadreInfo.where(empty:false)
		@topCinqs = @offre.my_top_five_candidates

		unless params[:remuneration].empty?
    	maximum_salar = params[:remuneration].to_i
    	@cadre_infos = @cadre_infos.where("question4 <= #{maximum_salar}")
		end

    unless params[:disponility].empty?
    	@cadre_infos = @cadre_infos.where(disponibilite: params[:disponility])
    end

    unless params[:metier].empty?
      metier = Metier.find_by_id(params[:metier])
      unless metier.nil?
      	@cadre_infos = @cadre_infos.where(metier:metier)
      end
    end

    my_cadres = []

		region = params[:region]
   
    unless region.empty? && @cadre_infos.empty?
      region = Region.find_by_id(region)
    	@cadre_infos.each do |cadre_info|
    		if params[:region] == "all"
    			my_cadres.push(cadre_info)
    		else
					if cadre_info.region.name == "Toutes les régions" || cadre_info.region == region
						my_cadres.push(cadre_info)
					end
    		end
    	end
    	@cadre_infos = my_cadres
    end
		
		if params[:remuneration].empty? && params[:disponility].empty? && params[:metier].empty? && params[:region].empty?
			@cadre_infos = []
		end

    respond_to do |format|
      format.html do
        redirect_to searchJob_path
      end
      format.js do
      end
    end
		
	end

	def show_search_candidate
		@offre = OffreJob.find_by_id(params[:offre_id])
		@cadre = Cadre.find_by_id(params[:id]).cadre_info
		helpers.updateNotification(params[:secure])
	end

	def add_top_five_candidate
		# liste des id des cadre ajouter au favôries
		cadre_ids = params[:cadre_ids].split(",")
		@offre = OffreJob.find_by_id(params[:id])

		cadre_ids.each do |cadre_id|

			cadre = Cadre.find_by_id(cadre_id)
			number = @offre.my_top_five_candidates.count
			oFc = @offre.is_in_this_job(cadre)
			if number < 5 #if number of favorite cadre < 5
				if oFc.nil?
					OffreForCandidate.create(offre_job: @offre, cadre: cadre, accepted_postule:true)
				else
					# accepter demande d'entretien en ajoutan au favôries
					oFc.update(accepted_postule:true,repons_postule:true)
				end
			end

		end

		if @offre.etapes == 1
			@offre.next_stape
		end

		redirect_to show_favorite_cadres_path(@offre.id)

	end

	def save_entretien_client
		@offre = OffreJob.find_by_id(params[:offre_id].to_i)
		@cadre = Cadre.find_by_id(params[:cadre_id].to_i)
		@oFc = OffreForCandidate.find_by(offre_job_id: @offre.id, cadre_id: @cadre.id)
		
		name_entretien = params[:name] == "1" ? params[:client_name] : params[:name]
		name_adresse = params[:adresse] == "on" ? params[:adresse_name] : params[:adresse]+", #{@offre.client.entreprise.city}"

		if @oFc.nil?
			@oFc = OffreForCandidate.create(offre_job: @offre, cadre: @cadre, accepted_postule:true)
		else
			@oFc.update(accepted_postule:true)
		end

    date = params[:date].split("-")
    time = params[:time].split(":")

    year = date[0].to_i
    month = date[1].to_i
    day = date[2].to_i
    hour = time[0].to_i
    min = time[1].to_i

    @agenda = AgendaClient.new(entretien_date:DateTime.new(year,month,day,hour,min).utc, adresse: name_adresse, recruteur: name_entretien, offre_for_candidate: @oFc)

    unless @agenda.save
    	flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
    	redirect_to root_path
		else
			max_step = 0
			@offre.my_top_five_candidates.each do |oFc|
				numberOfc = oFc.agenda_clients.count
				if max_step < numberOfc
					max_step = numberOfc
				end
			end
			@offre.update(etapes:2+max_step)
			@oFc.update(etapes:@oFc.agenda_clients.count)
			@oFc.update(status:nil)
			name_entreprise = current_client.entreprise.name
			#notifaka
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} vous a envoyée une demande d'entretien.",link: "#{received_job_path(notification:"entretien")}",genre: 1,medel_id: @offre.id,view: false)
    end

		respond_to do |format|
			format.html { redirect_to show_search_candidate_path(@cadre.id) }
			format.js { }
		end

	end


	def update_entretien_client
		# save_entretien_client
		@cadre = Cadre.find_by_id(params[:cadre_id])
		@offreJob = OffreJob.find_by_id(params[:offre_id])
    @agendaClient = AgendaClient.find_by_id(params[:ac_id])
    @oFc = @agendaClient.offre_for_candidate
		name_entreprise = current_client.entreprise.name
    case params[:repons]
    when "0" #REFUSER
      @agendaClient.update(repons_client: false)
      @oFc.update(status:"refused")
      #notifaka
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} a refusé votre proposition pour la date de l'entretien.",link: "#{show_recrutment_monitoring_path(@oFc.id,notification:"entretien")}",genre: 2,medel_id: @offreJob.id,view: false)
    when "1"	#ACCEPTER
			date = DateTime.parse(@agendaClient.alternative)
      @agendaClient.update(entretien_date:date.utc,alternative: nil, repons_cadre:true, is_update:true,repons_client: true)
    	#notifaka
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} a accepté votre proposition pour la date d'entretien.",link: "#{show_recrutment_monitoring_path(@oFc.id,notification:"entretien")}",genre: 2,medel_id: @offreJob.id,view: false)
    when "2"
      date = params[:date].split("-")
      time = params[:time].split(":")
      year = date[0].to_i
      month = date[1].to_i
      day = date[2].to_i
      hour = time[0].to_i
      min = time[1].to_i
      date_time = DateTime.new(year,month,day,hour,min).utc
      @agendaClient.update(entretien_date: date_time, alternative: nil, repons_cadre:nil, is_update:true)
      #notifaka
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} a proposé une autre date pour l'entretien.",link: "#{received_job_path(notification:"entretien")}",genre: 1,medel_id: @offreJob.id,view: false)
    else
      flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
      redirect_to root_path
    end
    redirect_to recruitment_show_cadre_path(@oFc.id)
		respond_to do |format|
			format.html { redirect_back(fallback_location: root_path) }
			format.js { }
		end
		
	end

#Mes candidats favoris
	def favorite_candidates
		@offres = current_client.offre_jobs
	end

	def show_favorite_cadres
		@offre = OffreJob.find_by_id(params[:id])
		@oFcs = @offre.my_top_five_candidates
		#repons_cadre in offre_job
	end

#Mon suivi recrutement
	def my_recruitment_follow
		@offres = current_client.offre_jobs
	end

	def recruitment_liste_cadre
		@offre = OffreJob.find_by_id(params[:offre_id])
		@oFcs = @offre.offre_for_candidates.where(accepted_postule:true)
	end

	def recruitment_show_cadre
		helpers.updateNotification(params[:secure])
		@oFc = OffreForCandidate.find_by_id(params[:oFc_id])
		@offre = @oFc.offre_job
		@cadre = @oFc.cadre
		@agendas = @oFc.agenda_clients.order('created_at DESC')[0]
		@promise = @offre.promise_to_hires.find_by(cadre:@cadre)
	end

	def notice_refused_post
		respons = ["accepted","waiting","refused"]
		@oFc = OffreForCandidate.find_by_id(params[:oFc_id])
		@offre = OffreJob.find_by_id(params[:offre_id])
		@cadre = Cadre.find_by_id(params[:cadre_id])
		error = false
		unless respons.include?(params[:repons])
			error = true
		end
		if @oFc.nil? || @offre.nil? || @cadre.nil?
			error = true
		else
			unless @oFc.offre_job == @offre && @oFc.cadre == @cadre
				error = true
			end
		end
		if error
			flash[:alert] = "Une erreur s'est produite lors de la vérification des données."
			redirect_to root_path
		else
			name_entreprise = current_client.entreprise.name
			etapes = ""
			message = ""
			case @oFc.etapes
				when 1
					etapes = "première"
				when 2
					etapes = "deuxième"
				when 3
					etapes = "troisième"
			end
			case params[:repons]
			  when "accepted" #REFUSER
			  	message = "#{name_entreprise} a validé votre candidature pour la #{etapes} étape."
			  when "refused"	#ACCEPTER
			  	if params[:notifier].nil?
			  		message = "#{name_entreprise} a refusé votre candidature."
			  	else
						message = "#{name_entreprise} a envoyé la raison du refus de votre candidature."
					end
			end
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: message,link: "#{show_recrutment_monitoring_path(@oFc.id,notification:"entretien")}",genre: 2,medel_id: @offre.id,view: false)
			@oFc.update(status:params[:repons])
			@oFc.update(refused_info:params[:notifier])
			redirect_to recruitment_show_cadre_path(@oFc.id)
		end
		respond_to do |format|
			format.html { redirect_to root_path }
			format.js { }
		end
	end


# Une fois terminé, réglez les horaires de 15% de la rémunération annuelle brute de votre candidat retenu.

#Mes factures
	def my_bills
		@factures = Facture.all
	end

	def show_my_bills
		@facture = Facture.find_by_id(params[:id])
		@promise = @facture.promise_to_hire
		@offre_job = @promise.offre_job
	end

	def paye_my_bills
		# OffreJob.find_by_id(params[:offre_job_id])
		@facture = Facture.find_by_id(params[:facture_id])
		@promise = PromiseToHire.find_by_id(params[:promise_id])
		@offre_job = @facture.promise_to_hire.offre_job
		@promise.update(payed:true)
		flash[:notice] = "J'atteste régler cette facture par virement dans les 15jours."
		redirect_to show_my_bills_path(@facture.id)
	end

	def ov_my_bills
		@facture = Facture.find_by_id(params[:facture_id])
		# @facture.update(is_payed: true)
		redirect_to show_my_bills_path(@facture.id)
	end

#Mes notifications
	def notifications
		@notifications = current_client.notifications.where.not(genre:2).order("created_at DESC")
	end

	def show_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
		@job = @promise.offre_job
		@cadre = @promise.cadre.cadre_info
	end

#Promesse d'embauche
	def promise_to_hire
		@job = OffreJob.find_by_id(params[:id_offre_job])
		@cadre = Cadre.find_by_id(params[:id_cadre])
		if @job.nil? || @cadre.nil?
			#errors
		end
		@cadre = @cadre.cadre_info
		@promise = PromiseToHire.new
	end

	def save_promise_to_hire
		errorMessage = ""
		@job = OffreJob.find_by_id(params[:id_offre_job])
		@cadre = Cadre.find_by_id(params[:id_cadre])
		@promise = PromiseToHire.new(params.require(:promise_to_hire).permit(:date_poste, :remuneration_fixe, :remuneration_fixe_date, :remuneration_variable, :remuneration_avantage, :date_de_validite , :time_trying))
		@promise.offre_job = @job
		@promise.cadre = @cadre
		uploader = ImageUploader.new

		image_entreprise = params[:promise_to_hire][:signature_entreprise]
	  is_cv = true

		unless image_entreprise.nil?
	    begin
	      uploader.store!(image_entreprise)
	    rescue StandardError => e
	      is_cv = false
	      errorMessage += " [ #{e.message} ] "
	    end
		else
			errorMessage += " [ Importer votre signature en photo ] "
		end

    remuneration_info = params[:promise_to_hire][:remuneration_var_info]
    remuneration_variable = params[:promise_to_hire][:remuneration_variable]
    errorMessage += remuneration_variable_valid?(remuneration_variable,remuneration_info)

    if is_cv && @promise.valid? && errorMessage.empty?
    	@promise.remuneration_var_info = remuneration_info
      @promise.signature_entreprise = uploader.url
      @promise.save
      flash[:notice] = "Promesse d'embauche envoyée."
      name_entreprise = current_client.entreprise.name
			

			oFc = @job.my_top_five_candidates.find_by(cadre:@cadre)
			#notifaka
			# Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} vous a envoyée une promesse d'embauche.",link: "#{cadre_show_promise_to_hire_path(@promise.id,notification:"entretien")}",genre: 2,medel_id: @job.id,view: false)

			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} vous a envoyée une promesse d'embauche.",link: "#{show_recrutment_monitoring_path(oFc.id,notification:"entretien")}",genre: 2, medel_id: @job.id, view:false)

      #mettre à jour l'etap au dernière étape
			oFc.update(etapes:@job.numberEntretien + 1,status:nil)
			@job.update(etapes: 2 + @job.numberEntretien + 1)

      redirect_to show_promise_to_hire_path(@promise.id)
    else
			@promise.errors.details[:signature_entreprise] = errorMessage
    	flash[:alert] = @promise.errors.details
    	redirect_to promise_to_hire_path(id_offre_job:params[:id_offre_job], id:params[:id])
		end
	end

	def edit_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
		if @promise.repons_cadre
			flash[:alert] = "Vous ne pouvez plus modifier la promesse d'embauche."
			redirect_back(fallback_location: root_path)
			return
		end
		@job = @promise.offre_job
		@cadre = @promise.cadre.cadre_info
	end

	def update_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
		@job = @promise.offre_job
		@cadre = @promise.cadre
		if @promise.repons_cadre
			flash[:alert] = "Vous ne pouvez plus modifier la promesse d'embauche."
			redirect_back(fallback_location: root_path)
			return
		end
		my_parameters = params.require(:promise_to_hire).permit(:date_poste, :remuneration_fixe, :remuneration_fixe_date, :remuneration_variable, :remuneration_avantage, :date_de_validite, :time_trying)
		uploader = ImageUploader.new
		errorMessage = ""

    remuneration_info = params[:promise_to_hire][:remuneration_var_info]
    remuneration_variable = params[:promise_to_hire][:remuneration_variable]
    errorMessage += remuneration_variable_valid?(remuneration_variable,remuneration_info)

		image_entreprise = params[:promise_to_hire][:signature_entreprise]
	  is_cv = true
		unless image_entreprise.nil?
	    begin
	      uploader.store!(image_entreprise)
	    rescue StandardError => e
	      is_cv = false
	      errorMessage += " [ #{e.message} ] "
	    end
			if is_cv
				@promise.signature_entreprise = uploader.url
			end
		end
		
		if @promise.update(my_parameters) && is_cv && errorMessage.empty?
			unless remuneration_info.nil? || remuneration_info.empty?
				@promise.remuneration_var_info = remuneration_info
			end
      @promise.save
      flash[:notice] = "Mise à jour promesse d'embauche bien sauvegarder"

      name_entreprise = current_client.entreprise.name
			Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} a modifié sa promesse d'embauche.",link: "#{cadre_show_promise_to_hire_path(@promise.id,notification:"entretien")}",genre: 2,medel_id: @job.id,view: false)

      redirect_to show_promise_to_hire_path(@promise.id)
		else
			@promise.errors.details[:signature_entreprise] = errorMessage
    	flash[:alert] = @promise.errors.details
			redirect_to edit_promise_to_hire_path(@promise.id)
		end

	end

	def validate_time_trying_client
		@promise = PromiseToHire.find_by_confirm_token(params[:confirm_token])
    @offreJob = @promise.offre_job
    @cadre = @promise.cadre
    oFc = @offreJob.is_in_this_job(@cadre)
		name_entreprise = current_client.entreprise.name

		if @promise.client_time_trying.nil?
			if params[:date_rupture].nil?
				flash[:notice] = "Période d'essai bien validé."
		    @promise.update(client_time_trying:true)
				Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} a validé votre période d’essai.",link: "#{show_recrutment_monitoring_path(oFc.id,notification:"prime")}",genre: 2,medel_id: @offreJob.id,view: false)
			else
				if params[:date_rupture].empty?
				else
					flash[:notice] = "Rupture de la période d’essai ok!"
					@promise.update(client_time_trying:false,rupture_time_trying:params[:date_rupture])
					Notification.create(cadre: @cadre,object: "#{name_entreprise}",message: "#{name_entreprise} n'a pas validé votre période d'essai.",link: "#{show_recrutment_monitoring_path(oFc.id,notification:"prime")}",genre: 2,medel_id: @offreJob.id,view: false)
				end
			end
		end

    redirect_to recruitment_show_cadre_path(oFc.id)
	end

#~~~~~~~~~~ Message ~~~~~~~~~~~~~~~~~~~~
  def my_messages
    @candidats = Cadre.all
    @contactListes = current_client.contact_client_cadres
  end
=begin
	<h2>Liste de tous les CADRES dans le site</h2>
	<% @candidats.each do |cadre| %>
		<div>
			<a href="<%= rzshowMessages_path(cadre.id) %>">
			<%= cadre.cadre_info.first_name %> <%= cadre.cadre_info.last_name %>
			</a>
		</div>
	<% end %>
=end

  def show_my_messages
    @cadre = Cadre.find_by_id(params[:id])
    @contact = ContactClientCadre.where(cadre: @cadre, client:current_client)
    if @contact.count == 0
      @contact = ContactClientCadre.create(cadre: @cadre, client:current_client)
    else
      @contact = @contact.first
    end
		@contact.message_client_cadres.where(client_see:false).update(client_see:true)
    @messages = @contact.message_client_cadres.order(created_at: :ASC)
    @newMessage = MessageClientCadre.new
  end

  def post_my_message
    @cadre = Cadre.find_by_id(params[:message_client_cadre][:cadre_id])
    @contact = ContactClientCadre.find_by_id(params[:message_client_cadre][:contact_id])
    @content = params[:message_client_cadre][:content]
    @newMessage = MessageClientCadre.new(content: @content, client_see: true,contact_client_cadre: @contact,is_client:true)
		respond_to do |format|
      format.html do
        if @newMessage.save
        	@contact.message_client_cadres.update(client_see:true)
		      redirect_to rzshowMessages_path(@cadre.id)
		    else
		      flash[:alert] = @newMessage.errors.details
		      redirect_to rzshowMessages_path(@cadre.id)
		    end
      end
      format.js do
        if @newMessage.save
        	@contact.message_client_cadres.update(client_see:true)
          @errors = false
        else
          flash[:alert] = @newMessage.errors.details
		      redirect_to rzshowMessages_path(@cadre.id)
        end
      end
    end
  end

  def getLastMessage
    @cadre = Cadre.find_by_id(params[:cadre_id])
    @contact = ContactClientCadre.find_by_id(params[:contact_id])
    if @contact.nil?
      @messages = []
    else
      if @contact.client == current_client && @contact.cadre == @cadre
        @messages = @contact.message_client_cadres.order(created_at: :ASC).last(50)
      else
        @messages = []
      end
    end
  end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	private

	def post_params
		params.require(:offre_job).permit(:intitule_pote,:country,:region,:department,:descriptif_mission,:rattachement,:remuneration,:remuneration_anne,:contrat_cdi,:type_deplacement,:date_poste,:question1,:question2,:numberEntretien,:question4,:question5)
	end

	def remuneration_variable_valid?(remuneration_variable,remuneration_info)
		if remuneration_variable == "true" && remuneration_info.empty?
			return " [ Une erreur s'est produit lors de la vérification des données ] "
		else
			return ""
		end
	end

end
