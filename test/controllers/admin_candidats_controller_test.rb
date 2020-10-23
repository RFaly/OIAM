require 'test_helper'

class AdminCandidatsControllerTest < ActionDispatch::IntegrationTest
  test "should get be_processed" do
    get admin_candidats_be_processed_url
    assert_response :success
  end

  test "should get pending" do
    get admin_candidats_pending_url
    assert_response :success
  end

  test "should get processed" do
    get admin_candidats_processed_url
    assert_response :success
  end

  test "should get messaging" do
    get admin_candidats_messaging_url
    assert_response :success
  end

end
