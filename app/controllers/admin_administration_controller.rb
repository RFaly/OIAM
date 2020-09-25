class AdminAdministrationController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end
  def mail
  end
  def test
  end
  def utilisateur
  	@cadre = Cadre.all
  	@recruteur = Client.all
  end
end
