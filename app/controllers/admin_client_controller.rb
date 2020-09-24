class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end
  def offer
  	@offre = OffreJob.all
  end

  def show_offer
  	@offre = OffreJob.find_by(id: params[:id])
  end
  def factures
  end
end
