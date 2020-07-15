# frozen_string_literal: true

class Cadres::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :validate_cadre, only: [:new, :create]
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
    cookies.delete :oiam_cadre
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
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:mail, :city, :postal_code, :first_name, :last_name, :adresse, :situation, :telephone, :email, :password, :password_confirmation])
  # end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:mail, :city, :postal_code, :first_name, :last_name, :adresse, :situation, :telephone, :email, :password, :password_confirmation])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    edit_profil_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def validate_cadre
    if cookies.encrypted[:oiam_cadre].nil?
      redirect_to tmp_sign_up_path
    else
      @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
      if @cadre.nil?
        cookies.delete :oiam_cadre
        flash[:alert] = "Vous devez vous s'inscrire pour faire les tests!"
        redirect_to tmp_sign_up_path
      else
        @email = @cadre.mail
      end
    end
  end

end
