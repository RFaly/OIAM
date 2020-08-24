class AdminDashboardController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end
  def agenda
  end
  def offer
  end
  def candidate
  end
  def tache
  end
end
