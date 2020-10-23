# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @new_nav_bar = true
    @header = true
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || candidats_be_processed_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
