class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end
  def offer
  end
  def factures
  end
end
