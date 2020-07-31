require 'test_helper'

class AdminDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get admin_dashboard_main_url
    assert_response :success
  end

end
