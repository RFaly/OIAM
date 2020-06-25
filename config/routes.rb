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
	get '/cadre', to: 'candidates#main', as: 'main_cadre'
	devise_for :cadres, path: 'cadres', controllers: {
    sessions: 'cadres/sessions',
    registrations: 'cadres/registrations'
  }

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

=end
