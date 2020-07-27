class CandidatesController < ApplicationController
  before_action :authenticate_cadre!, only: [:confirmedProfil,:edit_profil, :my_profil, :searchJob, :favoriteJob, :recrutmentMonitoring, :getLastMessage]
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
    puts "~~~~"*43
    puts params.inspect
    puts "~~~~"*43
    puts post_params_tmp.inspect
    puts "~~~~"*43
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
    errorMessage = ""

    is_error = params[:cadre_info][:question1].empty? || params[:cadre_info][:question2].empty? || params[:cadre_info][:question3].empty? || params[:cadre_info][:question4].empty? || params[:cadre_info][:question5].empty? || params[:cadre_info][:status].empty?
    if is_error
      errorMessage += " [ Tous les champs sont obligatoire ] "
    end

    fileCv = FileUploader.new
    if params[:cadre_info][:cv].nil? && @cadre.cv.nil?
      errorMessage += " [ Importer votre CV ] "
    elsif !params[:cadre_info][:cv].nil?
      is_cv = true
      begin
        fileCv.store!(params[:cadre_info][:cv])
      rescue StandardError => e
        is_cv = false
        errorMessage += " [ CV: #{e.message} ] "
      end
      if is_cv
        @cadre.cv = fileCv.url
        @cadre.save
      end
    end

    uploader = ImageUploader.new
    if params[:cadre_info][:image].nil? && @cadre.image.nil?
      errorMessage += " [ Importer votre photo de profil ] "
    elsif !params[:cadre_info][:image].nil?
      is_img = true
      begin
        uploader.store!(params[:cadre_info][:image])
      rescue StandardError => e
        is_img = false
        errorMessage += " [ Photo: #{e.message} ] "
      end
      if is_img
        @cadre.image = uploader.url
        @cadre.save
      end
    end
    
    if errorMessage.empty?
      @cadre.update(post_params)
      @cadre.update(empty:false)
      redirect_to my_profil_path
    else
      flash[:alert] = "#{errorMessage}"
      render :edit_profil
      return
    end

  end

	def searchJob
    validate_info_cadre
    @offres = OffreJob.all

	end

	def favoriteJob
    validate_info_cadre
	end

  def addToFavoriteJob
    @offre = OffreJob.find_by_id(params[:id])
    if @offre.nil?
      redirect_to wellcome_path
    else
      @favoriteJob = FavoriteJob.create(offre_job: @offre, cadre: current_cadre)
      respond_to do |format|
        format.html do
          redirect_to searchJob_path
        end
        format.js do

        end
      end
    end
  end

  def removeToFavoriteJob
    @offre = OffreJob.find_by_id(params[:id])
    if @offre.nil?
      redirect_to wellcome_path
    else
      FavoriteJob.where(offre_job: @offre, cadre: current_cadre).destroy_all
      respond_to do |format|
        format.html do
          redirect_to searchJob_path
        end
        format.js do

        end
      end
    end
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

#~~~~~~~~~~ Message ~~~~~~~~~~~~~~~~~~~~
  def my_messages
    @clients = Client.all
    @contactListes = current_cadre.contact_client_cadres
  end

  def show_my_messages
    @client = Client.find_by_id(params[:id])
    @contact = ContactClientCadre.where(client: @client, cadre:current_cadre)
    if @contact.count == 0
      @contact = ContactClientCadre.create(client: @client, cadre:current_cadre)
    else
      @contact = @contact.first
    end
    #marquer tous comme lue
    @contact.message_client_cadres.where(cadre_see:false).update(cadre_see:true)
    @messages = @contact.message_client_cadres.order(created_at: :ASC)
    @newMessage = MessageClientCadre.new
  end

  def post_my_message
    @client = Client.find_by_id(params[:message_client_cadre][:client_id])
    @contact = ContactClientCadre.find_by_id(params[:message_client_cadre][:contact_id])
    @content = params[:message_client_cadre][:content]
    @newMessage = MessageClientCadre.new(content:@content, cadre_see: true,contact_client_cadre: @contact,is_client:false)

    respond_to do |format|
      format.html do
        if @newMessage.save
          @contact.message_client_cadres.update(cadre_see:true)
          redirect_to zshowMessages_path(@client.id)
        else
          flash[:alert] = @newMessage.errors.details
          redirect_to zshowMessages_path(@client.id)
        end
      end
      format.js do
        if @newMessage.save
          @contact.message_client_cadres.update(cadre_see:true)
          @errors = false
        else
          flash[:alert] = @newMessage.errors.details
          redirect_to zshowMessages_path(@client.id)
        end
      end
    end
  end

  def getLastMessage
    @client = Client.find_by_id(params[:client_id])
    @contact = ContactClientCadre.find_by_id(params[:contact_id])
    if @contact.nil?
      @messages = []
    else
      if @contact.client == @client && @contact.cadre == current_cadre
        @messages = @contact.message_client_cadres.order(created_at: :ASC).last(50)
      else
        @messages = []
      end
    end
  end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
    params.require(:cadre_info).permit(:last_name,:first_name,:adresse,:postal_code,:city,:situation,:telephone,:mail)
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
