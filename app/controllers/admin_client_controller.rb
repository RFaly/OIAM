class AdminClientController < ApplicationAdminController
  before_action :authenticate_admin!
  def main
  end
end
