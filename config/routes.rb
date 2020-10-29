Rails.application.routes.draw do
  get 'admin_administrations/home'
  #Notification cron job
  get '/727562792f67656dnotifed_cron_job732f322e372e302f', to: 'notifications#entretien_client_fit', as: 'notifed_entretien_client_fit'
  get '/6f6c696e696c6c6number_notice2f646570656e6465', to: 'notifications#number_notice', as: 'notifed_number_notice'
  get '/6e2f657874b378number_message38365f36342d6c696e', to: 'notifications#number_message', as: 'notifed_number_message'

  # routes pdf
  get '/recruteur/mes-factures/%:id_factures.26#%/facturation_pdf.pdf',to: 'facturation_pdf#index',as: 'facturation_pdf_to_pdf'
  get '/recruteur/offre-d-emploi/%:id_promise.26#%/contrat-d-embauche.pdf',to: 'facturation_pdf#promise',as: 'promise_pdf'
  get '/cadre/suivi-recrutement/%:id_promise.26#%/contrat-d-embauche.pdf',to: 'facturation_pdf#promise_cadre',as: 'promise_cadre_pdf'
	#~~~~~~~~~~~~~~~~~~~~ Accueil ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  root to: 'static_page#home'
  get '/welcome', to: 'static_page#allHome', as: 'welcome'

  get '/méthodologie', to: 'static_page#methodology', as: 'methodology'
  get '/politique_confidentialite', to: 'static_page#politique_confidentialite', as: 'confidentialite'
  get '/equipe', to: 'static_page#equipe', as: 'equipe'
  get '/portfolio', to: 'static_page#portfolio', as: 'portfolio'
  get '/contact', to: 'static_page#contact', as: 'contact'
  get '/condition_general', to: 'static_page#condition_general', as: 'condition_general'

  get '/oiam', to: 'static_page#nothing', as: 'nothing'

  post '/contact/save', to: 'static_page#save_contact_us', as: 'save_contact_us'
  post '/contact/subscriber', to: 'static_page#save_app_subscriber', as: 'save_app_subscriber'

	#~~~~~~~~~~~~~~~~~~~~~~~~ Client ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :clients, path: 'clients', controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }, path_names: {
    sign_in: 'se-connecter', sign_out: 'se-deconneter', cancel: 'supprimer',
    password: 'mot-de-passe', confirmation: 'verification',
    registration: 'inscription', edit: 'editer', sign_up: 'cree-compte'
  }

	get '/recruteur', to: 'recruteurs#main', as: 'main_recruiter'

  # list menu dans le dashbord client
  #mon profl
  get '/recruteur/mon-profil', to: 'recruteurs#my_profil', as: 'client_my_profil'
  #edit profil
  get '/recruteur/mon-profil/edit', to: 'recruteurs#my_profil_edit', as: 'my_profil_edit'
  patch '/recruteur/mon-profil/save', to: 'recruteurs#update_my_profil', as: 'update_my_profil'

  #mes offre d'emploi
  get '/recruteur/mes-offre-d-emploi', to: 'recruteurs#my_job_offers', as: 'my_job_offers'
  get '/recruteur/mes-candidats-favoris', to: 'recruteurs#favorite_candidates', as: 'favorite_candidates'
  get '/recruteur/mes-candidats-favoris/:id/listes', to: 'recruteurs#show_favorite_cadres', as:'show_favorite_cadres'
  get '/recruteur/mon-suivi-recrutement', to: 'recruteurs#my_recruitment_follow', as: 'my_recruitment_follow'

  # mes suvi recrutement
  get '/recruteur/mon-suivi-recrutement/:offre_id/liste-cadres', to: 'recruteurs#recruitment_liste_cadre', as: 'recruitment_liste_cadre'
  get '/recruteur/mon-suivi-recrutement/liste-cadres/:oFc_id/cadre', to: 'recruteurs#recruitment_show_cadre', as: 'recruitment_show_cadre'

  # mes facture
  get '/recruteur/mes-factures', to: 'recruteurs#my_bills', as: 'my_bills'
  get '/recruteur/mes-factures/:id/view', to: 'recruteurs#show_my_bills', as: 'show_my_bills'

  post '/recruteur/mes-factures/paye', to: 'recruteurs#paye_my_bills', as: 'paye_my_bills'
  post '/recruteur/mes-factures/post-ov/paye', to: 'recruteurs#ov_my_bills', as: 'ov_my_bills'

  # notification
  get '/recruteur/mes-notifications', to: 'recruteurs#notifications', as: 'client_notifications'

  # creation offre d'emploi
  get '/recruteur/nouvelle-offre', to: 'recruteurs#newJob', as: 'newJob'
  post '/recruteur/publier-offre', to: 'recruteurs#createJob', as: 'createJob'
  # affichage offre d'emploi
  get '/recruteur/edit/:id/offre', to: 'recruteurs#editJob', as: 'editJob'
  patch '/recruteur/edit/:id/offre', to: 'recruteurs#updateJob', as: 'updateJob'
  delete '/recruteur/supprimer/offre/:id', to: 'recruteurs#destroyJob', as: 'destroyJob'

  get '/recruteur/mes-offre-d-emploi/:id/offre', to: 'recruteurs#showNewJob', as: 'showNewJob'
  patch '/recruteur/publier/:id/-offre', to: 'recruteurs#publish', as: 'publish'

  get '/recruteur/offre/:id/notre-selection', to: 'recruteurs#our_selection', as: 'our_selection'
  get '/recruteur/offre/:id/recherche-candidat', to: 'recruteurs#search_candidate', as: 'search_candidate'
  get '/recruteurs/offre/:id/candidate', to:'recruteurs#show_search_candidate', as:'show_search_candidate'
  post '/recruteurs/favorite/:id/candidate', to:'recruteurs#add_top_five_candidate', as:'add_top_five_candidate'
  post '/recruteurs/envoyer-invitation-entretien', to:'recruteurs#save_entretien_client', as:'save_entretien_client'
  post '/recruteurs/envoyer-reponse-entretien', to:'recruteurs#notice_refused_post', as:'notice_refused_post'
  post '/recruteurs/candidate-change/reponse-entretien', to:'recruteurs#update_entretien_client', as:'update_entretien_client'

  # show promesse d'embauche
  get '/recruteur/offre-d-emploi/:id/contrat-d-embauche', to: 'recruteurs#show_promise_to_hire', as: 'show_promise_to_hire'
  #create a promesse d'embauche
  get '/recruteur/:id_offre_job/:id_cadre/embauche', to: 'recruteurs#promise_to_hire', as: 'promise_to_hire'
  post '/recruteur/:id_offre_job/:id_cadre/contrat-embauche', to: 'recruteurs#save_promise_to_hire', as: 'save_promise_to_hire'
  #edit a promesse d'embauche
  get '/recruteur/:id/edit-embauche', to: 'recruteurs#edit_promise_to_hire', as: 'edit_promise_to_hire'
  patch '/recruteur/:id/edit-contrat-embauche', to: 'recruteurs#update_promise_to_hire', as: 'update_promise_to_hire'

  #validate periode d'essai candidate
  post '/recruteur/suivi-recrutement/confirmation-periode-d-essai', to: 'recruteurs#validate_time_trying_client', as: 'validate_time_trying_client'

  # barre de recherche candidat
  post '/recruteur/recherche-cadre', to: 'recruteurs#search_bar_cadre', as: "search_bar_cadre"

  #messagerie admin
  get '/recruteur/messagerie/admin', to: 'recruteurs#messagerie_admin', as: 'messagerie_client_admin'
  get '/recruteur/messagerie/admin/:id', to: 'recruteurs#show_message_admin', as: 'show_message_client_admin'
  post '/recruteur/send-message/admin', to: 'recruteurs#post_message_admin', as: 'post_message_client_admin'

	#~~~~~~~~~~~~~~~~~~~~~~~~ Candidate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  get '/cadre', to: 'candidates#main', as: 'main_cadre'
  get '/cadre/inscription-candidat', to: 'candidates#tmp_sign_up', as: 'tmp_sign_up'
  post '/cadre/go-inscription', to: 'candidates#tmp_create_sign_up', as: 'tmp_create_sign_up'

  # les 3 test a faire
  get '/cadre/welcome-to-test', to: 'candidates#my_tests', as: 'my_tests'

  get '/cadre/potential-test', to: 'candidates#testpotential', as: 'testpotential'
  get '/cadre/go-potential-test', to: 'candidates#init_testpotential', as: 'init_testpotential'

  # repons with api(marquer que le cadre a fait le test potential)
  post '/cadre/repons-test-potential', to:'candidates#save_repons_test_potential', as:'save_repons_test_potential'

  # resultat test
  get '/cadre/resultat-test', to: 'candidates#resultatsTest', as: 'resultatsTest'

  #getScoresPotential in ajax
  get '/cadre/score-potential/:confirm_token/ok', to: 'candidates#getScoresPotential', as:'getScoresPotential'

  post '/cadre/email/score', to:'candidates#save_scores_potential_test', as:'save_scores_potential_test'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # a enlever pour l'instant # get '/cadre/skills-test', to: 'candidates#testskills', as: 'testskills'
  # post '/cadre/send/metier', to:'candidates#postMetierSkills', as:'postMetierSkills'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  get '/cadre/fit-test', to: 'candidates#testfit', as: 'testfit'
  post '/cadre/save-entretien-date', to:'candidates#saveEntretientDate',as:'saveEntretientDate'

  #maketo
  post '/cadre/score-resultats-test-potentiel', to:"candidates#createScorePototial", as:'createScorePototial'



  #formation liste

  get 'cadre/formation', to: 'formation_candidate#index', as: 'formation_all'
  get 'cadre/formation/:formation_id/:name', to: 'formation_candidate#date_rdv', as: 'formation_date_rdv'
  post 'cadre/formation/save', to: 'formation_candidate#save_rdv', as: 'formation_save_rdv'


  #messagerie pour admin
  get '/cadre/messagerie/admin', to:'candidates#messagerie_admin', as: 'messagerie_admin'
  get '/cadre/messagerie/admin/:id', to:'candidates#show_message_admin', as: 'show_message_admin'
  post '/cadre/send-message/admin', to:'candidates#post_message_admin', as: 'post_message_admin'

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	devise_for :cadres, path: 'cadre', controllers: {
    sessions: 'cadres/sessions',
    registrations: 'cadres/registrations'
  }, path_names: {
    sign_in: 'se-connecter', sign_out: 'se-deconneter', cancel: 'supprimer',
    password: 'mot-de-passe', confirmation: 'verification',
    registration: 'inscription', edit: 'editer', sign_up: 'cree-compte'
  }

  # list menu dans le dashbord candidat
  get '/cadre/mon-profil', to: 'candidates#my_profil', as: 'my_profil'
  post '/cadre/mon-profil/validate', to: 'candidates#validate_profil', as: 'validate_profil'
  get '/cadre/mon-profil/edit', to: 'candidates#edit_profil', as: 'edit_profil'
  get '/cadre/mes_tests', to: 'candidates#main_test', as: 'main_test'
  patch '/cadre/confirmed-profil', to: 'candidates#confirmedProfil', as: 'confirmedProfil'

  get '/cadre/offres', to: 'candidates#searchJob', as: 'searchJob'
  get '/cadre/offres-personnalise', to:'candidates#jobsPersonalized', as:'jobsPersonalized'
  get '/cadre/offres-favorites', to: 'candidates#favoriteJob', as: 'favoriteJob'
  get '/cadre/recherche/:id/offre', to: 'candidates#showSearchJob', as: 'showSearchJob'
  post '/cadre/offre/:id/me-postuler', to: 'candidates#apply_for_job', as: 'apply_for_job'
  post '/cadre/add-offres-to-favorites', to: 'candidates#addToFavoriteJob', as: 'addToFavoriteJob'
  delete '/cadre/remove-offres-to-favorites', to: 'candidates#removeToFavoriteJob', as: 'removeToFavoriteJob'
  get '/cadre/mes-offres-reçues', to: 'candidates#received_job', as: 'received_job'
  post '/cadre/post-repons-received-job', to:'candidates#post_repons_received_job', as: 'post_repons_received_job'
  get '/cadre/suivi-recrutement', to: 'candidates#recrutmentMonitoring', as: 'recrutment_monitoring'
  get '/cadre/suivi-recrutement/:ofc_id/mon-progression', to: 'candidates#showRecrutmentMonitoring', as: 'show_recrutment_monitoring'

  get '/cadre/suivi-recrutement/:id/promesse-d-embauche', to: 'candidates#cadre_show_promise_to_hire', as: 'cadre_show_promise_to_hire'
  patch '/cadre/suivi-recrutement/:id_pdm/validate-promesse-d-embauche', to: 'candidates#cadre_update_promise_to_hire', as: 'cadre_update_promise_to_hire'

  # reclamer la prime et message de felicitation
  get '/cadre/suivi-recrutement/:confirm_token/félicitations', to: 'candidates#congratulations_cadre', as: 'congratulations_cadre'

  post '/cadre/suivi-recrutement/confirmation-periode-d-essai', to: 'candidates#validate_time_trying_cadre', as: 'validate_time_trying_cadre'

  post '/cadre/suivi-recrutement/félicitations/prime', to: 'candidates#save_coordinate_banking', as: 'save_coordinate_banking'

  get '/cadre/mes-notifications', to: 'candidates#notifications', as: 'cadres_notifications'

  # barre de recherche candidat
  post '/cadre/recherche-offre', to: 'candidates#search_bar_job', as: "search_bar_job"

  #~~~~~~~~~~ LINK fo MESSAGE ~~~~~ TEST CANDIDAT
  get '/cadre/messages', to: 'candidates#my_messages', as: 'my_messages_cadre'
  get '/cadre/messages/:id', to: 'candidates#show_my_messages', as: 'show_my_messages_cadre'
  post '/cadre/send-message', to: 'candidates#post_my_message', as: 'post_my_message_cadre'
  get '/cadre/:client_id/:contact_id/all-messages', to:'candidates#getLastMessage', as:'getCadreLastMessage'

  #~~~~~~~~~~ LINK fo MESSAGE ~~~~~ TEST RECRUTEUR
  get '/recruteur/messages', to: 'recruteurs#my_messages', as: 'my_messages_client'
  get '/recruteur/messages/:id', to: 'recruteurs#show_my_messages', as: 'show_my_messages_client'
  post '/recruteur/send-message', to: 'recruteurs#post_my_message', as: 'post_my_message_client'
  get '/recruteur/:cadre_id/:contact_id/all-messages', to:'recruteurs#getLastMessage', as:'getClientLastMessage'

  #~~~~~~~~~~~~~~~~~~~~~~~~ Admin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Lien pour authentification admin
  devise_for :admins, path: 'secret-oiam-page/admin',:skip => [:registrations], controllers: {
    sessions: "admins/sessions"
  }, path_names: {
    sign_in: 'se-connecter', sign_out: 'se-deconneter', cancel: 'supprimer',
    password: 'mot-de-passe', confirmation: 'verification', edit: 'editer'
  }

  #home
  get 'secret-oiam-page/tableau-de-bord', to: 'admin_administrations#home', as: 'dashbord_admin'

  #clients
  get 'secret-oiam-page/admin-clients/a-traiter', to: 'admin_clients#be_processed', as: 'clients_be_processed'
  get 'secret-oiam-page/admin-clients/en-attente', to: 'admin_clients#pending', as: 'clients_pending'
  get 'secret-oiam-page/admin-clients/traitées', to: 'admin_clients#processed', as: 'clients_processed'
  get 'secret-oiam-page/admin-clients/messageries', to: 'admin_clients#messaging', as: 'clients_messaging'

  #cadre
  get 'secret-oiam-page/admin-candidats/a-traiter', to: 'admin_candidats#be_processed', as: 'candidats_be_processed'
  get 'secret-oiam-page/admin-candidats/en-attente', to: 'admin_candidats#pending', as: 'candidats_pending'
  get 'secret-oiam-page/admin-candidats/traitées', to: 'admin_candidats#processed', as: 'candidats_processed'
  get 'secret-oiam-page/admin-candidats/messageries', to: 'admin_candidats#messaging', as: 'candidats_messaging'

  # a traiter
  get 'secret-oiam-page/admin-candidats/a-traiter/inscription/:id', to: 'be_processeds_admin_candidates#be_processed_inscription', as: 'cbp_inscription'
  
  # valider entretien fit
  get 'secret-oiam-page/admin-candidats/a-traiter/entretin-fit/:id', to: 'be_processeds_admin_candidates#be_processed_validate_entretien_fit', as: 'cbp_validate_entretien_fit'
  post 'secret-oiam-page/admin-candidats/a-traiter/entretin-fit/valider', to: 'be_processeds_admin_candidates#validate_post_entretien_fit', as: 'validate_post_entretien_fit'


  get 'secret-oiam-page/admin-candidats/a-traiter-entretien-fit/:id', to: 'be_processeds_admin_candidates#be_processed_efectue_entretien_fit', as: 'post_avis_candidats_fit'
  get 'secret-oiam-page/admin-candidats/profil-non-complete/:id', to: 'be_processeds_admin_candidates#be_processed_profil_no_complete', as: 'cbp_profil_no_complete'
  get 'secret-oiam-page/admin-candidats/promise-non-valide/:id', to: 'be_processeds_admin_candidates#be_processed_pomise_no_validate', as: 'cbp_promise_no_validate'
  get 'secret-oiam-page/admin-candidats/prime/:id', to: 'be_processeds_admin_candidates#be_processed_prime', as: 'cbp_prime'
  post 'secret-oiam-page/admin-candidats/entretien-fit', to: 'be_processeds_admin_candidates#bp_efectue_entretien_fit', as: 'bp_efectue_entretien_fit'


  #messagerie cadre
  get 'secret-oiam-page/admin-candidats/messageries/:id', to: 'admin_candidats#show_message', as: 'candidats_show_message'
  post 'secret-oiam-page/admin-candidats/send/messages', to: 'admin_candidats#post_message', as: 'candidats_post_message'

  #messagerie clients
  get 'secret-oiam-page/admin-clients/messageries/:id', to: 'admin_clients#show_message', as: 'clients_show_message'
  post 'secret-oiam-page/admin-clients/send/messagers', to: 'admin_clients#post_message', as: 'clients_post_message'

end


=begin
        new_client_session GET    /clients/sign_in(.:format)       clients/sessions#new
    destroy_client_session DELETE /clients/sign_out(.:format)      clients/sessions#destroy
       new_client_password GET    /clients/password/new(.:format)  devise/passwords#new
      edit_client_password GET    /clients/password/edit(.:format) devise/passwords#edit
cancel_client_registration GET    /clients/cancel(.:format)        clients/registrations#cancel
   new_client_registration GET    /clients/sign_up(.:format)       clients/registrations#new
  edit_client_registration GET    /clients/edit(.:format)          clients/registrations#edit

         new_cadre_session GET    /cadres/sign_in(.:format)        cadres/sessions#new
     destroy_cadre_session DELETE /cadres/sign_out(.:format)       cadres/sessions#destroy
        new_cadre_password GET    /cadres/password/new(.:format)   devise/passwords#new
       edit_cadre_password GET    /cadres/password/edit(.:format)  devise/passwords#edit
 cancel_cadre_registration GET    /cadres/cancel(.:format)         cadres/registrations#cancel
    new_cadre_registration GET    /cadres/sign_up(.:format)        cadres/registrations#new
   edit_cadre_registration GET    /cadres/edit(.:format)           cadres/registrations#edit

         new_admin_session GET    /admins/sign_in(.:format)        admins/sessions#new
     destroy_admin_session DELETE /admins/sign_out(.:format)       admins/sessions#destroy
        new_admin_password GET    /admins/password/new(.:format)   devise/passwords#new
       edit_admin_password GET    /admins/password/edit(.:format)  devise/passwords#edit
 cancel_admin_registration GET    /admins/cancel(.:format)         admins/registrations#cancel
    new_admin_registration GET    /admins/sign_up(.:format)        admins/registrations#new
   edit_admin_registration GET    /admins/edit(.:format)           admins/registrations#edit
=end
