class AdminClientsBeProcessedController < ApplicationAdminController

	def show_client
		@client = Client.find_by_id(params[:id])
	end

	def offre_job_no_cadre
		@offre_job = OffreJob.find_by_id(params[:id])
	end

	def effectue_entretien
		@agenda_client = AgendaClient.find_by_id(params[:id])
		@cadre_info = @agenda_client.offre_for_candidate.cadre.cadre_info
		@offre_job  = @agenda_client.offre_for_candidate.offre_job
		@client = @agenda_client.offre_for_candidate.offre_job.client
	end

	def periode_rompre
		@promise = PromiseToHire.find_by_id(params[:id])
		@client = @promise.offre_job.client
		@cadre_info = @promise.cadre.cadre_info
	end
end
