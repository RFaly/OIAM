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
    @cadreInfoRecrutmentActs.uniq!

    # 12. Accepter/Refuser une promesse d’embauche
    # Liste candidats qui ont eu une promesse d'embauche et qui n'ont pas répondu
    @cadreInfoNotPromiseToHires = Cadre.joins(:promise_to_hires).where(promise_to_hires:{repons_cadre:nil}).distinct

    # 13. Valider sa période d’essai
    # Liste des candidats qui sont arrivés au bout de leur période d'essai et qui n'ont pas encore été validés dans le système.
    @cadreInfoValidateTimeTryings = []
    PromiseToHire.all.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}","%d/%m/%Y").past? && (pTH.client_time_trying.nil? || pTH.cadre_time_trying.nil?)
        @cadreInfoValidateTimeTryings.push([pTH,pTH.cadre.id])
      end
    end
    @cadreInfoValidateTimeTryings.uniq!

    # 14: Recevoir sa prime
    # Liste des candidats qui n'ont pas reçu leur prime
    @cadreInfoPrimNotReceiveds = []
    pTHs = PromiseToHire.where(client_time_trying:true,cadre_time_trying:true,repons_client:true,repons_cadre:true,prime_received:false)
    pTHs.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}",'%d/%m/%Y').past?
        @cadreInfoPrimNotReceiveds.push([pTH,pTH.cadre.id])
      end
    end
    @cadreInfoPrimNotReceiveds.uniq!

  end

  def pending



  end

  def processed
    #1. Inscription  
    #Inscription terminée
    @finishedSignUps = CadreInfo.where.not(is_recrute:nil)

    # 2. Tests Potential
    # Test potential (nom+prenom..), afficher le résultat du test, statut (admis ou refusé)
    @cadreInfoPotentielNotEnds = CadreInfo.where.not(score_potential:nil)

    # 4. Clique sur lien TP positif et planifie un entretien FIT  
    # RDV entretiens FIT effectués et validés(entretiens effectués)
    @cadreInfoFits = CadreInfo.joins(:agenda_admin).where.not(agenda_admins:{accepted:nil})

    # 5. Passe Entretien FIT
    # Entretien FIT traité (entretien fait et colpte rendu uploadé)
    @cadreInfoEnterScoreFits = CadreInfo.where.not(compte_rendu:nil,avis:nil)

    #8. Complète les informations du profil
    #Profil complété
    @cacadreInfoInCompleteInfoProfils = CadreInfo.where(is_recrute:true,empty:false)

    # 12. Accepter/Refuser une promesse d’embauche
    # Liste des candidats qui ont validé leur promesse d embauche
    @cadreInfoNotPromiseToHires = Cadre.joins(:promise_to_hires).where.not(promise_to_hires:{repons_cadre:nil})

    # 13. Valider sa période d’essai
    # Liste des candidats dont la période d essai est validée

    @cadreInfoValidateTimeTryings = []
    PromiseToHire.all.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}","%d/%m/%Y").past? && !pTH.client_time_trying.nil? && !pTH.cadre_time_trying.nil?
        @cadreInfoValidateTimeTryings.push([pTH,pTH.cadre.id])
      end
    end

    # 14. Recevoir sa prime
    # Liste des candidats qui ont reçu leur prime
    @cadreInfoPrimNotReceiveds = []
    pTHs = PromiseToHire.where(client_time_trying:true,cadre_time_trying:true,repons_client:true,repons_cadre:true,prime_received:true)
    pTHs.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}",'%d/%m/%Y').past?
        @cadreInfoPrimNotReceiveds.push([pTH,pTH.cadre.id])
      end
    end

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






<div class="mandona">
    <!-- <h2>Candidats à relancer pour les ateliers coaching</h2> -->
    <% unless @cadreInfoRefuseds.empty? %>
      <% @cadreInfoRefuseds.each do |cadreInfoRefused| %>
        <div data-name=".coaching" class="orange">
          <img src='/image/profie.png' alt='photo de profil' width='120px' height="120px" /> <br>
          <%= cadreInfoRefused.first_name %> <%= cadreInfoRefused.last_name %> <br>
          Score potentiel: <%= cadreInfoRefused.score_potential %> <br>
          <% unless cadreInfoRefused.score_fit.nil? %>
            Score fit: <%= cadreInfoRefused.score_fit %><br>
            <!-- #cadreInfoRefused.compatibilite -->
          <% else %>
            Score fit: ~ <br>
        <% end %>
        <a href="#">VOIR</a>
        </div>
      <% end %>
    <% end %>
</div>

<% unless @cadreNotInOffreForCandidates.empty? %>
  <% @cadreNotInOffreForCandidates.each do |cadreNotInOffreForCandidate| %>
    <% cifo = cadreNotInOffreForCandidate.cadre_info %>
    <div data-name=".cadreNotInOffreForCandidate" class="orange">
      <h2>PROFIL NON COMPLETE</h2>
      <div>
        <%= cifo.first_name %> <%= cifo.last_name %>
      </div>
      <div>
        Datee d'entrée: ~
      </div>
      <div>
        Date limite: ~
      </div>
      <div>
        <a href="#">GERER</a>
      </div>
    </div>
  <% end %>
<% end %>



<% unless @cadreInfoRecrutmentActs.empty? %>
  <% @cadreInfoRecrutmentActs.each do |cadreInfoRecrutmentAct| %>
    <% cifo = cadreInfoRecrutmentAct %>
    <div data-name=".cadreInfoRecrutmentAct" class="orange">
      <h2>PROFIL NON COMPLETE</h2>
      <div>
        <%= cifo.first_name %> <%= cifo.last_name %>
      </div>
      <div>
        Datee d'entrée: ~
      </div>
      <div>
        Date limite: ~
      </div>
      <div>
        <a href="#">GERER</a>
      </div>
    </div>
  <% end %>
<% end %>

=end
