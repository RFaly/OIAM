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
    	errorMessage += " [ Ajouter votre logo ] "
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
	end

##validation
	def createJob
		@offre = OffreJob.new(post_params)
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
		
	end

	def search_candidate
		@offre = OffreJob.find_by_id(params[:id])
		@topCinqs = OffreForCandidate.where(offre_job_id: @offre.id, accepted_postule:true)[0..4]
		@cadres = Cadre.joins(:cadre_info).where("cadre_infos.empty = ?",false)
	end

	def show_search_candidate
		@offre = OffreJob.find_by_id(params[:offre_id])
		@cadre = Cadre.find_by_id(params[:id]).cadre_info
	end

	def add_top_five_candidate
		cadre_ids = params[:cadre_ids].split(",")
		@offre = OffreJob.find_by_id(params[:id])

		cadre_ids.each do |cadre_id|
			cadre = Cadre.find_by_id(cadre_id)
			number = OffreForCandidate.where(offre_job: @offre, accepted_postule:true).count
			oFc = @offre.is_in_this_job(cadre)
			if oFc.nil?
				if number < 5
					OffreForCandidate.create(status: "en attente", offre_job: @offre, cadre: cadre, accepted_postule:true)
				end
			else
				oFc.update(accepted_postule:true)
			end
		end

	end

	def save_entretien_client
		name_entretien = params[:name] == "1" ? params[:client_name] : params[:name]
		name_adresse = params[:adresse] == "on" ? params[:adresse_name] : params[:adresse]

		@offre = OffreJob.find_by_id(params[:offre_id].to_i)
		@cadre = Cadre.find_by_id(params[:cadre_id].to_i)

		@oFc = OffreForCandidate.find_by(offre_job_id: @offre.id, cadre_id: @cadre.id)
		if @oFc.nil?
			@oFc = OffreForCandidate.create(status: "en attente", offre_job: @offre, cadre: @cadre, accepted_postule:true)
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
    end

		respond_to do |format|
			format.html { redirect_to show_search_candidate_path(@cadre.id) }
			format.js { }
		end

	end

#Mes candidats favoris
	def favorite_candidates
		@offres = current_client.offre_jobs
	end

#Mon suivi recrutement
	def my_recruitment_follow
		@offres = current_client.offre_jobs
	end

#Mes factures
	def my_bills
	end

#Mes notifications
	def notifications
	end

	def show_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
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
		@promise = PromiseToHire.new(params.require(:promise_to_hire).permit(:date_poste, :remuneration_fixe, :remuneration_fixe_date, :remuneration_variable, :remuneration_avantage, :date_de_validite))
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
      flash[:notice] = "Promesse d'embauche bien sauvegarder"
      redirect_to show_promise_to_hire_path(@promise.id)
    else
			@promise.errors.details[:signature_entreprise] = errorMessage
    	flash[:alert] = @promise.errors.details
    	redirect_to promise_to_hire_path(id_offre_job:params[:id_offre_job], id:params[:id])
		end
	end

	def edit_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
		@job = @promise.offre_job
		@cadre = @promise.cadre.cadre_info
	end

	def update_promise_to_hire
		@promise = PromiseToHire.find_by_id(params[:id])
		my_parameters = params.require(:promise_to_hire).permit(:date_poste, :remuneration_fixe, :remuneration_fixe_date, :remuneration_variable, :remuneration_avantage, :date_de_validite)
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
      redirect_to show_promise_to_hire_path(@promise.id)
		else
			@promise.errors.details[:signature_entreprise] = errorMessage
    	flash[:alert] = @promise.errors.details
			redirect_to edit_promise_to_hire_path(@promise.id)
		end

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
		params.require(:offre_job).permit(:country,:region,:department,:intitule_pote,:descriptif_mission,:rattachement,:remuneration,:remuneration_anne,:contrat_cdi,:type_deplacement,:date_poste,:question1,:question2,:question3,:question4,:question5)
	end

	def remuneration_variable_valid?(remuneration_variable,remuneration_info)
		if remuneration_variable == "true" && remuneration_info.empty?
			return " [ Une erreur s'est produit lors de la vérification des données ] "
		else
			return ""
		end
	end

end
