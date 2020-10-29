require 'test_helper'

class AdminAdministrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get admin_administrations_home_url
    assert_response :success
  end

end
