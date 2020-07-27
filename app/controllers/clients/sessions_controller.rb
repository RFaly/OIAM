# frozen_string_literal: true

class Clients::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    current_client.update(online_time: Time.current - 6.minutes)
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    current_client.edit_online_time
    stored_location_for(resource) || client_my_profil_path
  end

  def after_sign_out_path_for(resource_or_scope)
    welcome_path
  end
end
