require 'test_helper'

class CadreControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get cadre_main_url
    assert_response :success
  end

end
