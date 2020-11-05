require 'test_helper'

class AdminAgendasControllerTest < ActionDispatch::IntegrationTest
  test "should get agenda" do
    get admin_agendas_agenda_url
    assert_response :success
  end

end
