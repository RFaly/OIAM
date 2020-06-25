require 'test_helper'

class RecruiterControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get recruiter_main_url
    assert_response :success
  end

end
