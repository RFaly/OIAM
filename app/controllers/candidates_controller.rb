class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, except: :main

  def main
  end

# dashbord
  def my_profil #miaraka ny profil sy test
    @cadre = current_cadre
    if @cadre.potential_test.nil? || @cadre.skils_test.nil? || @cadre.fit_test.nil?
      redirect_to my_tests_path
    elsif @cadre.question1.nil? || @cadre.question2.nil? || @cadre.question3.nil? || @cadre.question4.nil? || @cadre.question5.nil?
      redirect_to edit_profil_path
    end
  end


  def my_tests
    @cadre = current_cadre
  end

  def edit_profil
    @cadre = current_cadre
  end

  def confirmedProfil
    @cadre = current_cadre
    uploader = ImageUploader.new
    uploader.store!(params[:cadre][:image])
    
    if uploader.url.nil?
      redirect_back(fallback_location: root_path)
      #error
    else
      @cadre.image = uploader.url
      @cadre.update(post_params)
      @cadre.save
      redirect_to my_profil_path
    end

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

