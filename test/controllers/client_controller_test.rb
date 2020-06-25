require 'test_helper'

class ClientControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get client_main_url
    assert_response :success
  end

end
