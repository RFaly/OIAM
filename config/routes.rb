Rails.application.routes.draw do
  
  
  get 'cadre/main'
	#~~~~~~~~~~~~~~~~~~~~ Accueil ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  root to: 'static_page#home'
	get '/wellcome', to: 'static_page#allHome', as: 'wellcome'


	#~~~~~~~~~~~~~~~~~~~~ Recruteur ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	get '/recruteur', to: 'recruiter#main', as: 'main_recruiter'

	#~~~~~~~~~~~~~~~~~~~~ Candidate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	get '/cadre', to: 'cadre#main', as: 'main_cadre'

	#~~~~~~~~~~~~~~~~~~~~ Admin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end
