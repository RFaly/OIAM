require 'test_helper'

class FormationCandidateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get formation_candidate_index_url
    assert_response :success
  end

  test "should get date_rdv" do
    get formation_candidate_date_rdv_url
    assert_response :success
  end

end
