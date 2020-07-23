class RecruteursController < ApplicationController
	#before_action :authenticate_client!, except: :main

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
			flash[:notice] = "modification sauvegarder"
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

	def createJob
		@offre = OffreJob.new(post_params)
		@offre.client = current_client
		uploader = ImageUploader.new
    if params[:offre_job][:image].nil? && current_client.image.nil?
    	flash[:alert] = "Image non trouvé"
			return render :newJob
    elsif !params[:offre_job][:image].nil? && @offre.save
    	uploader.store!(params[:offre_job][:image])
    	@offre.image = uploader.url
    	@offre.save
    	redirect_to showNewJob_path(@offre)
		else
			flash[:alert] = @offre.errors.details
			return render :newJob
		end
	end


# alksdjmfkflsdjmlfkqjmlf
	def editJob
		@offre = OffreJob.find(params[:id])
	end

	def updateJob
		@offre = OffreJob.find(params[:id])
	end
# alksdjmfkflsdjmlfkqjmlf



	def showNewJob
		@offre = OffreJob.find(params[:id])
	end

	def publish
		@offre = OffreJob.find(params[:id])
		@offre.update(is_publish:true)
	end

	def our_selection
		
	end

	def  search_candidate

	end
#Mes candidats favoris
	def favorite_candidates
	end

#Mon suivi recrutement
	def my_recruitment_follow
	end

#Mes factures
	def my_bills
	end

#Mes notifications
	def notifications
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
  	is_cv = true
    begin
      uploader.store!(params[:promise_to_hire][:signature_entreprise])
    rescue StandardError => e
      is_cv = false
      errorMessage += " [ #{e.message} ] "
    end
    if is_cv
      @promise.signature_entreprise = uploader.url
    end

		remuneration_info = params[:promise_to_hire][:remuneration_var_info]
		if params[:promise_to_hire][:remuneration_variable] == "Oui" && remuneration_info.empty?
			errorMessage += " [ Une erreur s'est produit lors de la vérification des données ] "
		end

		if @promise.save && errorMessage.empty?
			@promise.update(remuneration_var_info: remuneration_info)
		else
			@promise.errors.details[:signature_entreprise] = errorMessage
    	flash[:alert] = @promise.errors.details
			return render :promise_to_hire, id:params[:id]
		end

	end

#Messages
	# def method_name
	# end

	private

	def post_params
		params.require(:offre_job).permit(:country,:region,:department,:intitule_pote,:descriptif_mission,:rattachement,:remuneration,:remuneration_anne,:contrat_cdi,:type_deplacement,:date_poste,:question1,:question2,:question3,:question4,:question5)
	end

end
