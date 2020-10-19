require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get entretien_client_fit" do
    get notifications_entretien_client_url
    assert_response :success
  end

  test "should get number_notice" do
    get notifications_number_notice_url
    assert_response :success
  end

end
