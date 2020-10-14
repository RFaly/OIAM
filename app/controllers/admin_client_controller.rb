class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
    @offre = OffreJob.all
    @cadre = Cadre.all
  end
  def offer
  	@offre = OffreJob.all
  end

  def show_offer
    helpers.updateNotification(params[:secure])
  	@offre = OffreJob.find_by(id: params[:id])
  end
  def factures
    @facture = Facture.all
  end

  def show_facture
    @facture = Facture.find_by(id: params[:id])
  end
end
