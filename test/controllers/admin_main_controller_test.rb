require 'test_helper'

class AdminMainControllerTest < ActionDispatch::IntegrationTest

  test "should get messaging" do
    get admin_main_messaging_url
    assert_response :success
  end

  test "should get notification" do
    get admin_main_notification_url
    assert_response :success
  end

end
