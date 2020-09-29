# frozen_string_literal: true

class Cadres::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @confirm_token = params[:comfirm]
    @cadreInfo = CadreInfo.find_by_confirm_token(@confirm_token)
    if @cadreInfo.nil?
      flash[:alert] = "Vous devez vous inscrire pour faire les tests!"
      redirect_to tmp_sign_up_path
    else
      @email = @cadreInfo.mail
      super
    end
  end

  # POST /resource
  def create
    @cadreInfo = CadreInfo.find_by_confirm_token(params[:confirm_token])
    if @cadreInfo.nil?
      flash[:alert] = "Vous devez vous inscrire pour faire les tests!"
      redirect_to tmp_sign_up_path
    else
      super
      @cadreInfo.update(cadre:current_cadre)
      # cookies.encrypted[:oiam_cadre]
      cookies.delete :oiam_cadre
    end
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:confirm_token,:email, :password, :password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:mail, :city, :postal_code, :first_name, :last_name, :adresse, :situation, :telephone, :email, :password, :password_confirmation])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    flash[:notice] = "Prenez 5 minutes pour répondre à notre questionnaire, afin de mieux cibler votre recherche"
    edit_profil_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
