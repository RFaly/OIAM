class FormationCandidateController < ApplicationController
  def index
    confirm_token = params[:comfirm]
    @cadreInfo = CadreInfo.find_by_confirm_token(confirm_token)
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
    
  end

  def my_formation
    
  end



end
