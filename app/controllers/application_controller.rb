class ApplicationController < ActionController::Base
  before_action :client_update_online_time, if: :client_signed_in?
  before_action :cadre_update_online_time, if: :cadre_signed_in?

  def client_update_online_time
    if current_client.online_time < 5.minutes.ago
			current_client.edit_online_time
    end
  end

  def cadre_update_online_time
    if current_cadre.online_time < 5.minutes.ago
			current_cadre.edit_online_time
    end
  end

end

#Ce(tte) candidat(e) n'est plus disponible.
# cadrefrees
