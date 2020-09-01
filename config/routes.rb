Rails.application.routes.draw do
	#~~~~~~~~~~~~~~~~~~~~ Accueil ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  root to: 'static_page#home'
  get '/welcome', to: 'static_page#allHome', as: 'welcome'

  get '/méthodologie', to: 'static_page#methodology', as: 'methodology'
  get '/equipe', to: 'static_page#equipe', as: 'equipe'
  get '/portfolio', to: 'static_page#portfolio', as: 'portfolio'
  get '/contact', to: 'static_page#contact', as: 'contact'

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
  get '/recruteur/mon-profil', to: 'recruteurs#my_profil', as: 'client_my_profil'
  get '/recruteur/mon-profil/edit', to: 'recruteurs#my_profil_edit', as: 'my_profil_edit'
  patch '/recruteur/mon-profil/save', to: 'recruteurs#update_my_profil', as: 'update_my_profil'

  get '/recruteur/mes-offre-d-emploi', to: 'recruteurs#my_job_offers', as: 'my_job_offers'
  get '/recruteur/mes-candidats-favoris', to: 'recruteurs#favorite_candidates', as: 'favorite_candidates'
  get '/recruteur/mes-candidats-favoris/:id/listes', to: 'recruteurs#show_favorite_cadres', as:'show_favorite_cadres'
  get '/recruteur/mon-suivi-recrutement', to: 'recruteurs#my_recruitment_follow', as: 'my_recruitment_follow'

  get '/recruteur/mon-suivi-recrutement/:offre_id/liste-cadres', to: 'recruteurs#recruitment_liste_cadre', as: 'recruitment_liste_cadre'
  get '/recruteur/mon-suivi-recrutement/liste-cadres/:oFc_id/cadre', to: 'recruteurs#recruitment_show_cadre', as: 'recruitment_show_cadre'

  get '/recruteur/mes-factures', to: 'recruteurs#my_bills', as: 'my_bills'
  get '/recruteur/mes-notifications', to: 'recruteurs#notifications', as: 'client_notifications'

  get '/recruteur/nouvelle-offre', to: 'recruteurs#newJob', as: 'newJob'
  post '/recruteur/publier-offre', to: 'recruteurs#createJob', as: 'createJob'

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

	#~~~~~~~~~~~~~~~~~~~~~~~~ Candidate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :cadres, path: 'cadre', controllers: {
    sessions: 'cadres/sessions',
    registrations: 'cadres/registrations'
  }, path_names: {
    sign_in: 'se-connecter', sign_out: 'se-deconneter', cancel: 'supprimer',
    password: 'mot-de-passe', confirmation: 'verification',
    registration: 'inscription', edit: 'editer', sign_up: 'cree-compte'
  }

	get '/cadre', to: 'candidates#main', as: 'main_cadre'
  get '/cadre/inscription-candidat', to: 'candidates#tmp_sign_up', as: 'tmp_sign_up'
  post '/cadre/go-inscription', to: 'candidates#tmp_create_sign_up', as: 'tmp_create_sign_up'

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

  get '/cadre/mes-notifications', to: 'candidates#notifications', as: 'cadres_notifications'
  # les 3 test a faire
  get '/cadre/welcome-to-test', to: 'candidates#my_tests', as: 'my_tests'
  get '/cadre/potential-test', to: 'candidates#testpotential', as: 'testpotential'
  get '/cadre/skills-test', to: 'candidates#testskills', as: 'testskills'
  get '/cadre/fit-test', to: 'candidates#testfit', as: 'testfit'

  # tokony post ito
  get '/cadre/resultat-test', to: 'candidates#resultatsTest', as: 'resultatsTest'
  post '/cadre/save-entretien-date', to:'candidates#saveEntretientDate',as:'saveEntretientDate'



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
  # routes principale dans admin_main
  get 'secret-oiam-page/admin', to: 'admin_main#home', as: 'admin_main_home'
  get 'secret-oiam-page/admin/messages', to: 'admin_main#messaging', as: 'admin_main_messaging'
  get 'secret-oiam-page/admin/notifications', to: 'admin_main#notification', as: 'admin_main_notification'
  get 'secret-oiam-page/admin/mon-profil', to: 'admin_main#my_profil', as: 'admin_main_my_profil'

  # route admin cadre
  get 'secret-oiam-page/admin/cadre/envoyer-un-message', to: 'admin_cadre#main', as: 'admin_cadre_main'
  # get 'secret-oiam-page/admin/cadre/envoyer-un-message', to: 'admin_cadre#send_message', as: 'admin_cadre_send_message'
  get 'secret-oiam-page/admin/cadre/entretien-fit', to: 'admin_cadre#entretien_fit', as: 'admin_cadre_entretien_fit'
  get 'secret-oiam-page/admin/cadre/coaching-workshop', to: 'admin_cadre#coaching_workshop', as: 'admin_cadre_coaching_workshop'
  get 'secret-oiam-page/admin/cadre/events', to: 'admin_cadre#events', as: 'admin_cadre_events'

  # route admin client
  get 'secret-oiam-page/admin/client/recrutement-en-cours', to: 'admin_client#main', as: 'admin_client_main'
  get 'secret-oiam-page/admin/client/offres-d-emploi', to: 'admin_client#offer', as: 'admin_client_offer'
  get 'secret-oiam-page/admin/client/factures-client', to: 'admin_client#factures', as: 'admin_client_factures'

  # routes dans le dashboard
  get 'secret-oiam-page/admin/dashboard', to: 'admin_dashboard#main', as: 'admin_dashboard_main'
  get 'secret-oiam-page/admin/dashboard/agenda', to: 'admin_dashboard#agenda', as: 'admin_dashboard_agenda'
  get 'secret-oiam-page/admin/dashboard/offres-en-cours', to: 'admin_dashboard#offer', as: 'admin_dashboard_offer'
  get 'secret-oiam-page/admin/dashboard/candidats-a-suivre', to: 'admin_dashboard#candidate', as: 'admin_dashboard_candidate'
  get 'secret-oiam-page/admin/dashboard/taches', to: 'admin_dashboard#tache', as: 'admin_dashboard_tache'

  # routes dans tache
  get 'secret-oiam-page/admin/dashboard/taches/mes-factures', to: 'admin_dashboard#factures', as: 'admin_dashboard_tache_factures'
  get 'secret-oiam-page/admin/dashboard/taches/mes-relances-clients', to: 'admin_dashboard#relances', as: 'admin_dashboard_tache_relances'
  get 'secret-oiam-page/admin/dashboard/taches/mes-taches-a-faire', to: 'admin_dashboard#taches', as: 'admin_dashboard_tache_taches'

  # routes dans pour l'administration
  get 'secret-oiam-page/admin/administration/les-agendas', to: 'admin_administration#main', as: 'admin_administration_main'
  get 'secret-oiam-page/admin/administration/les-mails', to: 'admin_administration#mail', as: 'admin_administration_mail'
  get 'secret-oiam-page/admin/administration/les-tests', to: 'admin_administration#test', as: 'admin_administration_test'
  get 'secret-oiam-page/admin/administration/les-utilisateurs', to: 'admin_administration#utilisateur', as: 'admin_administration_utilisateur'

  #formation liste

  get 'cadres/formation', to: 'formation_candidate#index', as: 'formation_all'
  get 'cadres/formation/:id', to: 'formation_candidate#date_rdv', as: 'formation_date_rdv'
  post 'cadres/formation/save', to: 'formation_candidate#save_rdv', as: 'formation_save_rdv'



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

