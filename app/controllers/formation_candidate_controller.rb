class FormationCandidateController < ApplicationController
  def index
  	@formations = Formation.all
  end

  def date_rdv
  	@formation = Formation.find_by_id(params[:formation_id])
  end

  def save_rdv
  	puts "~"*45
    puts params.inspect
    puts "~"*45
  end

end
