Rails.application.routes.draw do
	#~~~~~~~~~~~~~~~~~~~~ Accueil ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  root to: 'static_page#home'
  get '/wellcome', to: 'static_page#allHome', as: 'wellcome'

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
  get '/recruteur/mon_profil', to: 'recruteurs#my_profil', as: 'client_my_profil'
  get '/recruteur/mon_profil/edit', to: 'recruteurs#my_profil_edit', as: 'my_profil_edit'
  patch '/recruteur/mon_profil/save', to: 'recruteurs#update_my_profil', as: 'update_my_profil'


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
  
  #create a promesse d'embauche
  get '/recruteur/:id_offre_job/:id_cadre/embaucher', to: 'recruteurs#promise_to_hire', as: 'promise_to_hire'
  post '/recruteur/:id_offre_job/:id_cadre/contrat-embauche', to: 'recruteurs#save_promise_to_hire', as: 'save_promise_to_hire'

  #edit a promesse d'embauche
  get '/recruteur/:id/edit-embaucher', to: 'recruteurs#edit_promise_to_hire', as: 'edit_promise_to_hire'
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
  get '/cadre/mon_profil', to: 'candidates#my_profil', as: 'my_profil'
  get '/cadre/mon_profil/edit', to: 'candidates#edit_profil', as: 'edit_profil'
  get '/cadre/mes_tests', to: 'candidates#my_tests', as: 'my_tests'
  
  patch '/cadre/confirmed-profil', to: 'candidates#confirmedProfil', as: 'confirmedProfil'

  get '/cadre/mon_profil/offres', to: 'candidates#searchJob', as: 'searchJob'
  get '/cadre/mon_profil/offres-favorites', to: 'candidates#favoriteJob', as: 'favoriteJob'
  get '/cadre/mon_profil/suivi-recrutement', to: 'candidates#recrutmentMonitoring', as: 'recrutment_monitoring'

  # les 3 test a faire
  get '/cadre/potential-test', to: 'candidates#testpotential', as: 'testpotential'
  get '/cadre/skills-test', to: 'candidates#testskills', as: 'testskills'
  get '/cadre/fit-test', to: 'candidates#testfit', as: 'testfit'

  # tokony post ito
  get '/cadre/resultat-test', to: 'candidates#resultatsTest', as: 'resultatsTest'


	#~~~~~~~~~~~~~~~~~~~~~~~~ Admin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :admins, path: 'admins', controllers: {
  	sessions: 'admins/sessions',
  	registrations: 'admins/registrations'
  }

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
