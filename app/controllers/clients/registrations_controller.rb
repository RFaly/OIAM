# frozen_string_literal: true

class Clients::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # errorsList = []
    # if params[:entreprise_name].empty?
    #   errorsList.push("Champ NOM ENTREPRISE obligatoire")
    # end
    # if params[:entreprise_adresse].empty?
    #   errorsList.push("Champ ADRESSE obligatoire")
    # end
    # if params[:entreprise_siret].empty?
    #   errorsList.push("Champ SIRET obligatoire")
    # end
    # if params[:entreprise_site].empty?
    #   errorsList.push("Champ SITE INTERNET obligatoire.")
    # end
    # if params[:entreprise_description].empty?
    #   errorsList.push("Champ DESCRIPTION DE VOTRE ACTIVITÉ obligatoire")
    # end
    # if params[:postal_code].empty?
    #   errorsList.push("Champ code postal obligatoire")
    # end
    # if params[:city].nil? || params[:city].empty?
    #   errorsList.push("Champ ville obligatoire")
    # end
    # if params[:code_naf].empty?
    #   errorsList.push("Champ code Naf obligatoire")
    # end
    # if errorsList.empty?
      super
      # Entreprise.create(code_naf: params[:code_naf], name: params[:entreprise_name], adresse: params[:entreprise_adresse], siret: params[:entreprise_siret], site: params[:entreprise_site], description: params[:entreprise_description], postal_code: params[:postal_code], city: params[:city], client: current_client)
    # else
    #   redirect_to new_client_registration_path, alert: errorsList
    # end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fonction, :mail, :first_name, :last_name, :adresse, :situation, :telephone, :email, :password, :password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:fonction, :mail, :first_name, :last_name, :adresse, :situation, :telephone, :email, :password, :password_confirmation])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    client_my_profil_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
