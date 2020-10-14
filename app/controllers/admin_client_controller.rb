class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!

  #recrutement en cours
  def main
    @offres = OffreJob.all
  end

  #show recrutement en cours
  def show_recrutment
    @offre = OffreJob.find_by(id: params[:id])
  end

  def offer
  	@offre = OffreJob.all
  end

  def show_offer
    helpers.updateAdminNotification(params[:secure],current_admin)
  	@offre = OffreJob.find_by(id: params[:id])
  end

  def factures
    @facture = Facture.all
  end

  def show_facture
    @facture = Facture.find_by(id: params[:id])
  end

end
