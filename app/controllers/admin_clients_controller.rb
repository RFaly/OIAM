class AdminClientsController < ApplicationAdminController
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
