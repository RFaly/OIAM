class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, except: :main
  before_action :init_current_cadre, except: :main

  def main
  end

# dashbord
  def my_profil # miaraka ny profil sy test
    # if @cadre.potential_test.nil? || @cadre.skils_test.nil? || @cadre.fit_test.nil?
    #   redirect_to my_tests_path
    # elsif @cadre.question1.nil? || @cadre.question2.nil? || @cadre.question3.nil? || @cadre.question4.nil? || @cadre.question5.nil?
    #   redirect_to edit_profil_path
    # end
  end


  def my_tests
  end

  def edit_profil
  end

  def confirmedProfil
    uploader = ImageUploader.new
    if params[:cadre][:image].nil? && @cadre.image.nil?
      redirect_to edit_profil_path, alert: "Image non trouvé"
    elsif !params[:cadre][:image].nil?
      uploader.store!(params[:cadre][:image])
      @cadre.image = uploader.url
      @cadre.save
    end
    @cadre.update(post_params)
    redirect_to my_profil_path
  end

	def searchJob
	end

	def favoriteJob
	end

	def recrutmentMonitoring
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
 
  def post_params
    params.require(:cadre).permit(:question1,:question2,:question3,:question4,:question5)
  end

  def init_current_cadre
    @cadre = current_cadre
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
