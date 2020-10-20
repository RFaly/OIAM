class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!

  #recrutement en cours
  def main
    @offres = OffreJob.all.order('created_at DESC')
  end

  #show recrutement en cours
  def show_recrutment
    @offre = OffreJob.find_by(id: params[:id])
    @oFcs = @offre.offre_for_candidates.where(accepted_postule:true)
  end

  def manage_recrutment_admin
    @oFc = OffreForCandidate.find_by_id(params[:id])


    @offreJob = @oFc.offre_job
    @cadre = @oFc.cadre
    @agendas = @oFc.agenda_clients.order('created_at DESC')[0]
    # @promise = @offreJob.promise_to_hires.find_by(cadre:@cadre)
    @promise = @offreJob.promise_to_hires.joins(:cadre).find_by(cadre:@cadre)

  end

  def offer
  	@offre = OffreJob.all.order('created_at DESC')
  end

  def show_offer
    helpers.updateAdminNotification(params[:secure],current_admin)
  	@offre = OffreJob.find_by(id: params[:id])
  end

  def factures
    @facture = Facture.all.order('created_at DESC')
  end

  def show_facture
    @facture = Facture.find_by(id: params[:id])
    @pTh = @facture.promise_to_hire
    @cadreInfo = @pTh.cadre.cadre_info
    @client = @facture.client
  end

  def carte_client
    @client = Client.all.order('created_at DESC')
  end

  def show_client
    helpers.updateAdminNotification(params[:secure],current_admin)
    @client = Client.find_by(id: params[:id])
  end

  def all_promisetohire
    @promise = PromiseToHire.all
  end

  def show_promisetohire
    @promise = PromiseToHire.find_by_id(params[:id])
    @job = @promise.offre_job
    @cadre = @promise.cadre.cadre_info
  end
end
