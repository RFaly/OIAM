Rails.application.routes.draw do
	#~~~~~~~~~~~~~~~~~~~~ Accueil ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  root to: 'static_page#home'
	get '/wellcome', to: 'static_page#allHome', as: 'wellcome'

	#~~~~~~~~~~~~~~~~~~~~ Client ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	get '/recruteur', to: 'recruteurs#main', as: 'main_recruiter'
	devise_for :clients, path: 'clients', controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }

	#~~~~~~~~~~~~~~~~~~~~ Candidate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :cadres, path: 'cadres', controllers: {
    sessions: 'cadres/sessions',
    registrations: 'cadres/registrations'
  }

	get '/cadre', to: 'candidates#main', as: 'main_cadre'

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


	#~~~~~~~~~~~~~~~~~~~~ Admin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	devise_for :admins, path: 'admins', controllers: {
  	sessions: 'admins/sessions',
  	registrations: 'admins/registrations'
  }

end


=begin

===============================================================================

Some setup you must do manually if you haven't yet:

  Ensure you have overridden routes for generated controllers in your routes.rb.
  For example:

    Rails.application.routes.draw do
  get 'candidates/main'
  get 'recruteurs/main'
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end

===============================================================================


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
