class RecruteursController < ApplicationController
	before_action :authenticate_client!, except: :main

  def main
  end

#Mon profil
  def my_profil
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
			render :newJob
    elsif !params[:offre_job][:image].nil? && @offre.save
    	uploader.store!(params[:offre_job][:image])
    	@offre.image = uploader.url
    	@offre.save

    	redirect_to showNewJob_path(@offre)
		else
			flash[:alert] = @offre.errors.details
			render :newJob
		end
	end

	def showNewJob
		@offre = OffreJob.find(params[:id])
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

#Messages
	# def method_name
	# end

	private

	def post_params
		params.require(:offre_job).permit(:country,:region,:department,:intitule_pote,:descriptif_mission,:rattachement,:remuneration,:remuneration_anne,:contrat_cdi,:type_deplacement,:date_poste,:question1,:question2,:question3,:question4,:question5)
	end

end
