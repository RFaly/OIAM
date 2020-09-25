class AdminAdministrationController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  	@agenda = AgendaAdmin.all
  end
  def mail
  	@mail = CadreInfo.all
  end
  def test
  	@test = CadreInfo.all
  end
  def utilisateur
  	@cadre = Cadre.all
  	@recruteur = Client.all
  end
end
