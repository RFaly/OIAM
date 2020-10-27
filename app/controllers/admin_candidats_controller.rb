class AdminCandidatsController < ApplicationAdminController
	before_action :authenticate_admin!

  def be_processed

=begin


1. Inscription {
  Inscription non terminée
}
2. Tests Potential {
  # Test potentiel non terminé (en cours d eroute),récupérer son nom et email)
  @cadre_infos = CadreInfo.where(is_recrute:nil).where(score_potential:nil)
}

3. Ouverture Mail2 Résultat {
  # Candidats à relancer pour les ateliers coaching
  @cadre_infos = CadreInfo.where(is_recrute:false)
}

4. Clique sur lien TP positif et planifie un entretien FIT {
  # RDV Entretiens FIT à valider(nom+prenom, date+horaire rdv)
  @cadreInfoFit = CadreInfo.joins(:agenda_admin).where(agenda_admins:{accepted:nil})
}

5. Passe Entretien FIT {
  # Entretiens FIT à effectuer(nom+prénom+date)
  @cadreInfoEnterScoreFits = CadreInfo.where(is_recrute:nil).joins(:agenda_admin).where("agenda_admins.entretien_date < ?",DateTime.now.utc).where("agenda_admins.accepted=true")
}

6. Ouverture Mail3 Admission {
  
}

7. Clique sur lien Admission {
  
}

8. Complète les informations du profil{
  #Profil non complété
  @cacadreInfoFitdreInfoEmpty = CadreInfo.where(is_recrute:true,empty:true)
}

9. Cherche un offre d’emploi {
  # Liste des candidats qui n'ont pas encore postulé à une offre ou qui ne sont pas dans un process de recrutement
  @cadreNotInOffreForCandidate = Cadre.all - Cadre.joins(:offre_for_candidates).distinct

}

10. Postule à une offre d’emploi{
  
}

11. Accepter/Refuser une demande d’entretien{
  # Liste des candidats qui n'ont pas eu de retour du recruteur suit au rdv déjà passé.
  
  oFcs = OffreForCandidate.all
  oFcs.each do |oFc|

    agendat_client = oFc.agenda_clients.last





  end

  

  

}

12. Accepter/Refuser une promesse d’embauche{
  #Liste candidats qui ont eu une promesse d'embauche et qui n'ont pas répondu

  @cadreInfoNotPromiseToHire = Cadre.joins(:promise_to_hires).where(promise_to_hires:{repons_cadre:nil}).distinct

}

13. Valider sa période d’essai{
  # Liste des candidats qui sont arrivés au bout de leur période d'essai et qui n'ont pas encore été validés dans le système.

  @cadreInfoValidateTimeTrying = []
  PromiseToHire.all.each do |pTH|
    if DateTime.strptime("#{pTH}",'%j/%m/%Y').past? && (pTH.client_time_trying.nil? || pTH.cadre_time_trying.nil?)
      @cadreInfoValidateTimeTrying.push(pTH.cadre.cadre_info)
    end
  end

}

14: Recevoir sa prime {
  #Liste des candidats qui n'ont pas reçu leur prime

  @cadreInfoPrimNotReceived = []
  pTHs = PromiseToHire.where(client_time_trying:true,cadre_time_trying:true,repons_client:true,repons_cadre:true,prime_received:false)
  pTHs.each do |pTH|
    if DateTime.strptime("#{pTH}",'%j/%m/%Y').past?
      @cadreInfoPrimNotReceived.push(pTH.cadre.cadre_info)
    end
  end

}

=end


  end

  def pending
  end

  def processed
  end

  def messaging
    @cadre = Cadre.find_by_id(params[:id])
    @contactCadre = current_admin.contact_admin_cadres
    @contact = ContactAdminCadre.where(cadre: @cadre, admin:current_admin)
    if @contact.count == 0
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)
    else
      @contact = @contact.first
    end
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    @messages = @contact.message_admin_cadres.order(created_at: :ASC)
    @newMessage = MessageAdminCadre.new
  end

  def show_message
    @cadre = Cadre.find_by_id(params[:id])
    @contact = ContactAdminCadre.find_by(cadre: @cadre, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)    
	else
    	@contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
	end
    @messages = @contact.message_admin_cadres.order(created_at: :ASC)
    @newMessage = MessageAdminCadre.new
  end

  def post_message
  	@cadre = Cadre.find_by_id(params[:id_cadre])
  	@contact = ContactAdminCadre.find_by(id: params[:id_contact], admin: current_admin, cadre: @cadre)
    @content = params[:message_admin_cadre][:content]
    @newMessage = MessageAdminCadre.new(content:@content, cadre_see: false, contact_admin_cadre: @contact, is_admin: true)
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    if @newMessage.save      
      	redirect_to candidats_show_message_path(@cadre)
    else
      	flash[:alert] = @newMessage.errors.details
     	redirect_back(fallback_location: root_path)
    end
  end
end

=begin

#tous les candidats
@cadre_infos = CadreInfo.all

#cadre non admis
@cadre_infos = CadreInfo.where(is_recrute:false)

#cadre admis
@cadre_infos = CadreInfo.where(is_recrute:true)

# entretien fit
@cadre_infos = CadreInfo.where(is_recrute:nil).where.not(score_potential:nil)

=end