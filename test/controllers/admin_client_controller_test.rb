require 'test_helper'

class AdminClientControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get admin_client_main_url
    assert_response :success
  end

end
