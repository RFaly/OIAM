class FormationCandidateController < ApplicationController
  before_action :authenticate_cadre!, except: [:index,:date_rdv]

  def index
    confirm_token = params[:comfirm]
    @cadreInfo = CadreInfo.find_by_confirm_token(confirm_token)

    # cookies.encrypted[:oiam_cadre] = {
    #  value: @cadreInfo.confirm_token,
    #  expires: Time.now + 172800
    # }

  	@formations = Formation.all
    #comfirm
  end

  def date_rdv
  	@formation = Formation.find_by_id(params[:formation_id])
  end

  def save_rdv
  	puts "~"*45
    puts params.inspect
    puts "~"*45
  end

  def my_profil
    
  end

  def mes_test
    
  end

  def facture
    @FactureFormations = current_cadre.facture_formations
  end

  def my_formation
    
  end

end
