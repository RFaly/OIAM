require 'test_helper'

class AdminCadreControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get admin_cadre_main_url
    assert_response :success
  end

  test "should get send_message" do
    get admin_cadre_send_message_url
    assert_response :success
  end

  test "should get entretien_fit" do
    get admin_cadre_entretien_fit_url
    assert_response :success
  end

  test "should get coaching_workshop" do
    get admin_cadre_coaching_workshop_url
    assert_response :success
  end

  test "should get events" do
    get admin_cadre_events_url
    assert_response :success
  end

end
