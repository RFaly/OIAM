class AdminAdministrationsController < ApplicationAdminController
  def home
  end

  def facturation

# 10. Recevoir la facture du recrutement (mail + appli)
# Liste des recruteurs à envoyer des factures
		@factureNotConfirmedPayeds = []
		Facture.where(ov:nil).each do |facture|
			if facture.promise_to_hire.payed == false
				@factureNotConfirmedPayeds.push({facture:facture,client:facture.client,promise_to_hire:facture.promise_to_hire})
			end
		end

# Liste des recruteurs qui ont téléchargé les factures
		@factureConfirmedPayeds = []
		Facture.where(ov:nil).each do |facture|
			if facture.promise_to_hire.payed == true
				@factureConfirmedPayeds.push({facture:facture,client:facture.client,promise_to_hire:facture.promise_to_hire})
			end
		end

  end


  def show_facture
    @facture = Facture.find_by_id(params[:id])
    @pTh = @facture.promise_to_hire
    @cadreInfo = @pTh.cadre.cadre_info
    @client = @facture.client
  end

	def paiement
  	# 11. Valider paiement en uploadant l’OV
		# Liste des recruteurs en mode paiement

    # J'atteste régler cette facture par virement dans les 15 jours.

    @factureConfirmedPayeds = []
    Facture.where(ov:nil).each do |facture|
      if facture.promise_to_hire.payed == true && facture.created_at.next_day(15).past?
        @factureConfirmedPayeds.push({facture:facture,client:facture.client,promise_to_hire:facture.promise_to_hire})
      end
    end

  	# Liste des recruteurs qui ont validé le paiement
  	@facturePayeds = Facture.where.not(ov:nil)

  end

  def statistique
		# Statistiques générales de tous les tests effectués
		
		cadreInfos = CadreInfo.all
    @clientsNbr = Client.count

    @cadresNbr = Cadre.count

    @recruteNbr = Cadre.joins(:promise_to_hires).where(promise_to_hires: {repons_cadre:true}).uniq.count
    
    @recrutePercent = 0

    unless @cadresNbr == 0
    	@recrutePercent = (@recruteNbr*100)/@cadresNbr
    end

    @annoncesNbr = OffreJob.count

# REPONS_CADRE

    c_admis = cadreInfos.where(is_recrute:true)

    c_refuse = cadreInfos.where(is_recrute:false)

    en_cours = cadreInfos.where(is_recrute:nil)

    @allCadreNbr = cadreInfos.count

    # nombre
    @c_admisNbr = c_admis.count 
    @c_refuseNbr = c_refuse.count
    @en_coursNbr = en_cours.count
    
    # pourcentage
    @c_admisPercent = 0
    unless @allCadreNbr == 0
    	@c_admisPercent = ((@c_admisNbr* 100.0)/ @allCadreNbr).round()
    end

    c_refuse_potentialNbr = 0
    c_refuse_fitNbr = 0

    c_refuse.each do |cadre_info|
      case cadre_info.not_admited_test
        when "potential_test"
          c_refuse_potentialNbr += 1
        when "fit_test"
          c_refuse_fitNbr += 1
      end
    end

		@refusePotPercent = 0
		@refuseFitPercent = 0
		@en_coursPercent = 0

		unless @allCadreNbr == 0
	    @refusePotPercent = ((c_refuse_potentialNbr * 100.0) / @allCadreNbr).round()
	    @refuseFitPercent = ((c_refuse_fitNbr * 100.0) / @allCadreNbr).round()
	    @en_coursPercent = ((@en_coursNbr * 100.0)/ @allCadreNbr).round()
	    # @c_refusePercent = (@c_refuseNbr * 100.0) / @allCadreNbr
	  end

  end

end
