require 'test_helper'

class SpecialPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get special_page_home_url
    assert_response :success
  end

end
