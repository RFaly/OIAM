class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, except: :main

  def main
  end

# dashbord
  def my_profil #miaraka ny profil sy test
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
  <%= image_tag(@cadre.image, alt: 'Image')%>



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

