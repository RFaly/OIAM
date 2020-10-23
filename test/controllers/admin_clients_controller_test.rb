require 'test_helper'

class AdminClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get be_processed" do
    get admin_clients_be_processed_url
    assert_response :success
  end

  test "should get pending" do
    get admin_clients_pending_url
    assert_response :success
  end

  test "should get processed" do
    get admin_clients_processed_url
    assert_response :success
  end

  test "should get messaging" do
    get admin_clients_messaging_url
    assert_response :success
  end

end
