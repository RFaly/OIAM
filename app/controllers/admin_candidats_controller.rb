class AdminCandidatsController < ApplicationAdminController
	before_action :authenticate_admin!

  def be_processed

    allCadreInfos = CadreInfo.all
    # 1. Inscription {Inscription non terminée}

    # 2. Tests Potential
    # Test potentiel non terminé (en cours d eroute),récupérer son nom et email)
    @cadreInfoPotentielNotEnds = allCadreInfos.where(is_recrute:nil,score_potential:nil)

    # 3. Ouverture Mail2 Résultat
    # Candidats à relancer pour les ateliers coaching
    @cadreInfoRefuseds = allCadreInfos.where(is_recrute:false)


    # 4. Clique sur lien TP positif et planifie un entretien FIT
    # RDV Entretiens FIT à valider(nom+prenom, date+horaire rdv)
    @cadreInfoFits = allCadreInfos.joins(:agenda_admin).where(agenda_admins:{accepted:nil})


    # 5. Passe Entretien FIT
    # Entretiens FIT à effectuer(nom+prénom+date)
    @cadreInfoEnterScoreFits = allCadreInfos.where(is_recrute:nil).joins(:agenda_admin).where("agenda_admins.entretien_date < ?",DateTime.now.utc).where("agenda_admins.accepted=true")


=begin
    6. Ouverture Mail3 Admission {}
    7. Clique sur lien Admission {}
=end

    # 8. Complète les informations du profil
    # Profil non complété
    @cacadreInfoInCompleteInfoProfils = allCadreInfos.where(is_recrute:true,empty:true)


    # 9. Cherche un offre d’emploi
    # Liste des candidats qui n'ont pas encore postulé à une offre ou qui ne sont pas dans un process de recrutement
    @cadreNotInOffreForCandidates = Cadre.all - Cadre.joins(:offre_for_candidates).distinct

    # 10. Postule à une offre d’emploi{}

    # 11. Accepter/Refuser une demande d’entretien
    # Liste des candidats qui n'ont pas eu de retour du recruteur suit au rdv déjà passé.
    @cadreInfoRecrutmentActs = []
    oFcs = OffreForCandidate.where(status:nil)

    oFcs.each do |oFc|
      agendat_client = oFc.agenda_clients.last
      next if agendat_client.nil?
      if agendat_client.repons_client == true && agendat_client.repons_cadre == true && agendat_client.alternative.nil? && agendat_client.entretien_date.past?
        @cadreInfoRecrutmentActs.push(oFc.cadre.cadre_info)
      end
    end

    # 12. Accepter/Refuser une promesse d’embauche
    # Liste candidats qui ont eu une promesse d'embauche et qui n'ont pas répondu
    @cadreInfoNotPromiseToHires = Cadre.joins(:promise_to_hires).where(promise_to_hires:{repons_cadre:nil}).distinct

    # 13. Valider sa période d’essai
    # Liste des candidats qui sont arrivés au bout de leur période d'essai et qui n'ont pas encore été validés dans le système.
    @cadreInfoValidateTimeTryings = []
    PromiseToHire.all.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}","%j/%m/%Y").past? && (pTH.client_time_trying.nil? || pTH.cadre_time_trying.nil?)
        @cadreInfoValidateTimeTryings.push(pTH.cadre.cadre_info)
      end
    end

    # 14: Recevoir sa prime
    # Liste des candidats qui n'ont pas reçu leur prime
    @cadreInfoPrimNotReceiveds = []
    pTHs = PromiseToHire.where(client_time_trying:true,cadre_time_trying:true,repons_client:true,repons_cadre:true,prime_received:false)
    pTHs.each do |pTH|
      if DateTime.strptime("#{pTH}",'%j/%m/%Y').past?
        @cadreInfoPrimNotReceiveds.push(pTH.cadre.cadre_info)
      end
    end

  end

  def pending
  end

  def processed
  end

  def messaging
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