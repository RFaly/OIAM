class AdminClientsController < ApplicationAdminController
	before_action :authenticate_admin!
	
  def be_processed


  # 1. Inscription/Complétion du profil/Création compte/{
  #   Compte non créée
    @clients = Client.where(image:nil)
  # }


  # 5. Recherche et sélectionne des candidats.
  # Recruteur qui a déjà publié une offre mais à la recherche de candidats.
    @offreJobs = OffreJob.includes(:offre_for_candidates).where(offre_for_candidates: { id: nil })


  # 6. Planifie un/des entretiens en fonction du process de recrutement
  #   Liste des recruteurs qui ont envoyé une planification d'entretien aux candidats
    @listAgendaClientsSends = []
    OffreForCandidate.where(status:nil).each do |oFc|
      ac = oFc.agenda_clients.last
      unless ac.nil?
        if ac.alternative.nil? && ac.repons_client == true && ac.repons_cadre.nil? && ac.entretien_date > DateTime.now.utc
          @listAgendaClientsSends.push([oFc,ac])
        end
      end
    end


  # 7. Effectue l’ entretien et donne son feedback 
  # (Etape suivante, accepter, refuser, en attente)
  # Liste des recruteurs en mode entretien (entrain de faire des entretiens)
    @listAgendaClientsEntretiens = []
    OffreForCandidate.where(status:nil).each do |oFc|
      ac = oFc.agenda_clients.last
      unless ac.nil?
        if ac.repons_client && ac.repons_cadre && ac.alternative.nil? && ac.entretien_date < DateTime.now.utc
          @listAgendaClientsEntretiens.push([oFc,ac])
        end
      end
    end


  # 8. Remplir et envoyer une promesse d’embauche
  # Liste des recruteurs en mode remplissage de la promesse d'embauche
    @completedPromiseToHires = []

    OffreForCandidate.where(status:"accepted").each do |oFc|
      ac = oFc.agenda_clients.last
      offre = oFc.offre_job
      unless ac.nil?
        if ac.repons_client && ac.repons_cadre && ac.alternative.nil? && (ac.entretien_date < DateTime.now.utc) && (oFc.etapes >= offre.numberEntretien)
          pth = PromiseToHire.find_by(offre_job:offre, cadre:oFc.cadre)
          if pth.nil?
            @completedPromiseToHires.push([oFc,ac])
          end
        end
      end
    end

    # 12. Rompre la période d’essai
    # Liste des périodes d'essai à rompre
    @factures = Facture.joins(:promise_to_hire).where(promise_to_hires:{client_time_trying:false})

  end

  def pending

# 6. Planifie un/des entretiens en fonction du process de recrutement
# Planification d'entretien en attente du retour du candidat
    @listAgendaClientsSends = []
    OffreForCandidate.where(status:nil).each do |oFc|
      ac = oFc.agenda_clients.last
      unless ac.nil?
        if ac.alternative.nil? && ac.repons_client == true && ac.repons_cadre.nil? && ac.entretien_date > DateTime.now.utc
          @listAgendaClientsSends.push([oFc,ac])
        end
      end
    end

# 7. Effectue l’ entretien et donne son feedback
# (Etape suivante, accepter, refuser, en attente)
# Envoi du feedback en attente du retour du candidat
    @listAgendaClientsEntretiens = []
    OffreForCandidate.where(status:nil).each do |oFc|
      ac = oFc.agenda_clients.last
      unless ac.nil?
        if ac.repons_client && ac.repons_cadre && ac.alternative.nil? && ac.entretien_date < DateTime.now.utc
          @listAgendaClientsEntretiens.push([oFc,ac])
        end
      end
    end


# 9. Valider l’embauche
# Promesse d'embauche en attente du retour du candidat
    @cadreInfoNotPromiseToHires = Cadre.joins(:promise_to_hires).where(promise_to_hires:{repons_cadre:nil}).distinct

# 12. Valider une période d’essai
# En attente de la validation de la période d'essai
    @cadreInfoValidateTimeTryings = []
    PromiseToHire.all.each do |pTH|
      if DateTime.strptime("#{pTH.time_trying}","%d/%m/%Y").past? && (pTH.client_time_trying.nil? || pTH.cadre_time_trying.nil?)
        @cadreInfoValidateTimeTryings.push([pTH,pTH.cadre.id])
      end
    end
    @cadreInfoValidateTimeTryings.uniq!


  end

  def processed
    @processedHistories = ProcessedHistory.where(is_client:true).order(created_at: :DESC)
# 1. Inscription/Complétion du profil/Création compte/
#   Compte créée (fait)


# 5. Recherche et sélectionne des candidats
# Recruteur qui a publié une offre et a séléctionné des candidats


# 6. Planifie un/des entretiens en fonction du process de recrutement
# Planification d'entretien acceptée par le candidat

# 7. Effectue l’ entretien et donne son feedback 
# (Etape suivante, accepter, refuser, en attente)
# Feedback de l'entretien reçu et lu par le candidat

# 8. Remplir et envoyer une promesse d’embauche
# Promesse d'embauche envoyée

# 9. Valider l’embauche
# Promesse d'embauche acceptée/refusée par le candidat


# 10. Recevoir la facture du recrutement (mail + appli)
# Liste des recruteurs qui ont téléchargé les factures


# 11. Valider paiement en uploadant l’OV
# Liste des recruteurs qui ont validé le paiement

# 12. Valider une période d’essai
# Période d'essai validée

# 13. Rompre la période d’essai
# Liste des périodes d'essai rompues

  end

  def messaging
    @client = Client.find_by_id(params[:id])
    @contactClient = current_admin.contact_admin_clients
    @contact = ContactAdminClient.where(client: @client, admin:current_admin)
    if @contact.count == 0
      @contact = ContactAdminClient.create(client: @client, admin:current_admin)
    else
      @contact = @contact.first
    end
    @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    @messages = @contact.message_admin_clients.order(created_at: :ASC)
    @newMessage = MessageAdminClient.new
  end

  def show_message
    @client = Client.find_by_id(params[:id])
    @contact = ContactAdminClient.find_by(client: @client, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminClient.create(client: @client, admin:current_admin)    
    else
      @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    end
    @messages = @contact.message_admin_clients.order(created_at: :ASC)
    @newMessage = MessageAdminClient.new
  end

  def post_message
    @client = Cadre.find_by_id(params[:id_client])
    @contact = ContactAdminClient.find_by(id: params[:id_contact], admin: current_admin, client: @client)
    @content = params[:message_admin_client][:content]
    @newMessage = MessageAdminClient.new(content:@content, client_see: false, contact_admin_client: @contact, is_admin: true)
    @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    if @newMessage.save      
      redirect_to clients_show_message_path(@client)
    else
        flash[:alert] = @newMessage.errors.details
      redirect_back(fallback_location: root_path)
    end
  end
end
