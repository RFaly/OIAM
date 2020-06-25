require 'test_helper'

class CandidatesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get candidates_main_url
    assert_response :success
  end

end
