class AdminCandidatsController < ApplicationAdminController
	before_action :authenticate_admin!

  def be_processed
  end

  def pending
  end

  def processed
  end

  def messaging
  end
end

=begin

#tous les candidats
@cadre_infos = CadreInfo.all

#cadre non admis
@cadre_infos = CadreInfo.where(is_recrute:false)

#cadre admis
@cadre_infos = CadreInfo.where(is_recrute:true)

# entretien fit
@cadre_infos = CadreInfo.where(is_recrute:nil).where.not(score_potential:nil)

=end