Rails.application.routes.draw do
  # routes principale dans admin_main
  get 'secret-page/admin', to: 'admin_main#home', as: 'admin_main_home'
  get 'secret-page/admin/messages', to: 'admin_main#messaging', as: 'admin_main_messaging'
  get 'secret-page/admin/notifications', to: 'admin_main#notification', as: 'admin_main_notification'
  get 'secret-page/admin/mon-profil', to: 'admin_main#my_profil', as: 'admin_main_my_profil'

  # route admin cadre
  get 'secret-page/admin/cadre', to: 'admin_cadre#main', as: 'admin_cadre_main'
  get 'secret-page/admin/cadre/envoyer-un-message', to: 'admin_cadre#send_message', as: 'admin_cadre_send_message'
  get 'secret-page/admin/cadre/entretien-fit', to: 'admin_cadre#entretien_fit', as: 'admin_cadre_entretien_fit'
  get 'secret-page/admin/cadre/coaching-workshop', to: 'admin_cadre#coaching_workshop', as: 'admin_cadre_coaching_workshop'
  get 'secret-page/admin/cadre/events', to: 'admin_cadre#events', as: 'admin_cadre_events'

  # route admin client
  get 'secret-page/admin/client', to: 'admin_client#main', as: 'admin_client_main'

  # routes dans le dashboard
  get 'secret-page/admin/dashboard', to: 'admin_dashboard#main', as: 'admin_dashboard_main'

  # routes dans pour l'administration
  get 'secret-page/admin/administration', to: 'admin_administration#main', as: 'admin_administration_main'

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
  get '/recruteur/mon-suivi-recrutement', to: 'recruteurs#my_recruitment_follow', as: 'my_recruitment_follow'
  get '/recruteur/mes-factures', to: 'recruteurs#my_bills', as: 'my_bills'
  get '/recruteur/mes-notifications', to: 'recruteurs#notifications', as: 'client_notifications'

  get '/recruteur/nouvelle-offre', to: 'recruteurs#newJob', as: 'newJob'
  post '/recruteur/publier-offre', to: 'recruteurs#createJob', as: 'createJob'

  get '/recruteur/edit/:id/offre', to: 'recruteurs#editJob', as: 'editJob'
  patch '/recruteur/edit-offre', to: 'recruteurs#updateJob', as: 'updateJob'

  get '/recruteur/mes/:id/offre', to: 'recruteurs#showNewJob', as: 'showNewJob'
  patch '/recruteur/publier/:id/-offre', to: 'recruteurs#publish', as: 'publish'

  get '/recruteur/offre/:id/notre-selection', to: 'recruteurs#our_selection', as: 'our_selection'
  get '/recruteur/offre/:id/recherche-candidat', to: 'recruteurs#search_candidate', as: 'search_candidate'  
  
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
  get '/cadre/mon-profil/edit', to: 'candidates#edit_profil', as: 'edit_profil'
  get '/cadre/mes_tests', to: 'candidates#main_test', as: 'main_test'
  patch '/cadre/confirmed-profil', to: 'candidates#confirmedProfil', as: 'confirmedProfil'

  get '/cadre/offres', to: 'candidates#searchJob', as: 'searchJob'
  get '/cadre/offres-favorites', to: 'candidates#favoriteJob', as: 'favoriteJob'
  get '/cadre/recherche/:id/offre', to: 'candidates#showSearchJob', as: 'showSearchJob'
  post '/cadre/offre/:id/me-postuler', to: 'candidates#apply_for_job', as: 'apply_for_job'
  post '/cadre/add-offres-to-favorites', to: 'candidates#addToFavoriteJob', as: 'addToFavoriteJob'
  delete '/cadre/remove-offres-to-favorites', to: 'candidates#removeToFavoriteJob', as: 'removeToFavoriteJob'
  get '/cadre/mes-offres-reçues', to: 'candidates#received_job', as: 'received_job'
  get '/cadre/suivi-recrutement', to: 'candidates#recrutmentMonitoring', as: 'recrutment_monitoring'
  get '/cadre/mes-notifications', to: 'candidates#notifications', as: 'cadres_notifications'
  # les 3 test a faire
  get '/cadre/welcome-to-test', to: 'candidates#my_tests', as: 'my_tests'
  get '/cadre/potential-test', to: 'candidates#testpotential', as: 'testpotential'
  get '/cadre/skills-test', to: 'candidates#testskills', as: 'testskills'
  get '/cadre/fit-test', to: 'candidates#testfit', as: 'testfit'

  # tokony post ito
  get '/cadre/resultat-test', to: 'candidates#resultatsTest', as: 'resultatsTest'
  post '/cadre/save-entretien-date', to:'candidates#saveEntretientDate',as:'saveEntretientDate'
  
	#~~~~~~~~~~~~~~~~~~~~~~~~ Admin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :admins, path: 'admins', controllers: {
  	sessions: 'admins/sessions',
  	registrations: 'admins/registrations'
  }

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
