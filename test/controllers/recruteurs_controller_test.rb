require 'test_helper'

class RecruteursControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get recruteurs_main_url
    assert_response :success
  end

end
