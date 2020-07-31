require 'test_helper'

class AdminAdministrationControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get admin_administration_main_url
    assert_response :success
  end

end
