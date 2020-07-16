class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, only: [:confirmedProfil,:edit_profil, :my_profil, :searchJob, :favoriteJob, :recrutmentMonitoring]
  before_action :validate_cadre, only: [:my_tests, :testpotential, :testskills, :testfit, :resultatsTest]
  before_action :current_info_cadre, only: [:my_profil, :edit_profil, :confirmedProfil]

  def main
  end

  def tmp_sign_up
    unless cookies.encrypted[:oiam_cadre].nil?
      # @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
      flash[:notice] = "Vous pouvez continuer votre test!"
      redirect_to my_tests_path
    end
    @cadreInfo = CadreInfo.new
  end

  def tmp_create_sign_up
    @cadreInfo = CadreInfo.new(post_params_tmp)
    if @cadreInfo.save
      cookies.encrypted[:oiam_cadre] = {
        value: @cadreInfo.id,
        expires: Time.now + 172800
      }
      redirect_to my_tests_path
    else
      render :tmp_sign_up
    end
  end

# test: <%= cookies.encrypted[:oiam_cadre].nil? %>
# cookies.encrypted[:oiam_cadre]
# a = JSON.generate({name:'google'})
# JSON.parse(a)

# dashbord
  def my_profil
    validate_info_cadre
  end

  def my_tests
  end

  def edit_profil
  end

  def confirmedProfil
    uploader = ImageUploader.new
    file = FileUploader.new
    file.store!(params[:cadre_info][:cv])
    # if params[:cadre_info][:image].nil? && @cadre.image.nil?
    #   redirect_to edit_profil_path, alert: "Image non trouvé"
    # elsif !params[:cadre_info][:image].nil?
    #   uploader.store!(params[:cadre_info][:image])
    #   @cadre.image = uploader.url
    #   @cadre.save
    # end
    # @cadre.update(post_params)
    # @cadre.update(empty:false)
    # redirect_to my_profil_path
  end

	def searchJob
    validate_info_cadre
	end

	def favoriteJob
    validate_info_cadre
	end

	def recrutmentMonitoring
    validate_info_cadre
	end

# 3 test de recrutement
  def testpotential
  end

  def testskills
  end

  def testfit
  end

# Resultat test
  def resultatsTest
  end

  private

  def validate_cadre
    unless current_cadre
      if cookies.encrypted[:oiam_cadre].nil?
        flash[:alert] = "Vous devez vous s'inscrire pour faire les tests!"
        redirect_to tmp_sign_up_path
      else
        @cadre = CadreInfo.find_by_id(cookies.encrypted[:oiam_cadre])
        if @cadre.nil?
          cookies.delete :oiam_cadre
          flash[:alert] = "Vous devez vous s'inscrire pour faire les tests!"
          redirect_to tmp_sign_up_path
        end
      end
    end
  end

  def post_params_tmp
    params.require(:cadre_info).permit(:first_name,:adresse,:postal_code,:city,:situation,:telephone,:mail)
  end
 
  def post_params
    params.require(:cadre_info).permit(:question1,:question2,:question3,:question4,:question5)
  end

  def current_info_cadre
    @cadre = current_cadre.cadre_info
  end

  def validate_info_cadre
    if current_cadre.cadre_info.empty
      flash[:notice] = "Veuillez remplir votre profil"
      redirect_to edit_profil_path
    end
  end
end

=begin

before_action :authenticate_cadre!
cadre_signed_in?
current_cadre

before_action :authenticate_client!
client_signed_in?
current_client

before_action :authenticate_admin!
admin_signed_in?
current_admin

=end
